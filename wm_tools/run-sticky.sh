#!/usr/bin/env bash

set -eu

usage() {
	echo "Usage: $(basename "$0") cmd -- initialTitles"
	echo "  cmd				the command to run"
	echo "  initialTitles	initialTitles to follow"
}

if [[ $# -lt 3 ]]; then
	# need at least: "cmd" "--" "initialTitle"
	usage
	exit 1
fi

WS=$(hyprctl activeworkspace -j | jq -r '.id')

# build up the command and titles
CMD=()
TITLES=()
while [[ $# -gt 0 ]]; do
	if [[ "$1" == "--" ]]; then
		shift
		TITLES=("$@")
		break
	fi
	CMD+=("$1")
	shift
done

MATCHED=0
TOTAL=${#TITLES[@]}

handle() {
	local line="$1"
	local pid="$2"

	if ! kill -0 "$pid" 2>/dev/null; then
		# if pid dies, exit out of socat
		exit 1
	fi

	for title in "${TITLES[@]}"; do
		if [[ "$line" == *"$title"* ]]; then
			((MATCHED++)) || true
			[[ $MATCHED -ge $TOTAL ]] && exit 0
			return
		fi
	done
}

for title in "${TITLES[@]}"; do
	hyprctl keyword windowrule "workspace $WS silent,initialTitle:$title"
done

"${CMD[@]}" &
PID=$!

socat -u \
	UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
	while read -r line; do handle "$line" "$PID"; done

# after all initialTitles matched, unset window rules: we've bound the final
# window to the workspace the application was launched from
for title in "${TITLES[@]}"; do
	hyprctl keyword windowrule "workspace unset,initialTitle:$title" 2>/dev/null
done

wait $PID
