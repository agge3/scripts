#!/usr/bin/env bash

# emerge update command.
UPDATE_CMD="--verbose --update --deep --newuse --with-bdeps=y --backtrack=30 @world"

# Define a checkpoint file.
CHECKPOINT_FILE="/tmp/gentoo-update-checkpoint"

# Define the stages.
declare -A STAGES=(
	[1]="Sync system"
	[2]="Update Portage"
	[3]="Clean kernels"
	[4]="Update world"
	[5]="Clean dependencies"
	[6]="Rebuilds"
	[7]="Update NeoVim"
	[8]="Clean Perl modules"
	[9]="Handle Haskell (TODO)"
)

# Function to save current checkpoint.
save_checkpoint() {
	echo "$1" > "$CHECKPOINT_FILE"
}

# Function to load last checkpoint.
load_checkpoint() {
	[ -f "$CHECKPOINT_FILE" ] && cat "$CHECKPOINT_FILE" || echo 1
}

# Main driver.
main() {
	local start_stage=$(load_checkpoint)

	for stage_id in "${!STAGES[@]}"; do
		if (( stage_id >= start_stage )); then
			echo "=== Gentoo update stage $stage_id: ${STAGES[$stage_id]} ==="
			case $stage_id in
			1)
				eix-sync ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			2)
				emerge --oneshot sys-apps/portage ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			3)
				eclean-kernel --all ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			4)
				emerge "$UPDATE_CMD" ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			5)
				emerge --depclean ||
				{
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			6)
				emerge @module-rebuild ||
				{
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}

				emerge @golang-rebuild ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}

				emerge @preserved-rebuild ||
				{ 
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			7)
				nvim --headless "+Lazy! sync" +qa ||
				{
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			8)
				perl-cleaner --all ||
				{
					echo "Error in stage $stage_id: ${STAGES[$stage_id]}. Exiting."
					save_checkpoint $stage_id
					exit 1
				}
			;;

			9)
				echo "TODO: Handle Haskell updates (interactive handling not implemented yet)"
			;;

			*)
				echo "Unknown stage $stage_id. Exiting."
				exit 1
			;;
			esac

			save_checkpoint $(( stage_id + 1 ))
		fi
	done

  # Cleanup checkpoint file if all stages complete; finished.
  rm -f "$CHECKPOINT_FILE"
  echo "=== Gentoo update complete. All stages completed successfully! ==="
}

# Main entry point:
main
