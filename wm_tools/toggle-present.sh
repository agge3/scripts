#!/usr/bin/env bash

# run this script to toggle between presentation mode and personal mode.
# presentation mode uses generic KDE wallpaper, ghostty no opacity, etc.

TERM_CONF_F="$HOME/.config/ghostty/config"
WALLPAPER_CONF_F="$HOME/.config/hypr/hyprpaper.conf"

WALLPAPER_PRESENT=$(
	cat <<'EOF'
# uncomment for generic plasma wallpaper (for work)
preload = ~/repos/plasma-workspace-wallpapers/Altai/contents/images/5120x2880.png
wallpaper = DP-3,~/repos/plasma-workspace-wallpapers/Altai/contents/images/5120x2880.png
wallpaper = DP-2,~/repos/plasma-workspace-wallpapers/Altai/contents/images/5120x2880.png
wallpaper = HDMI-A-1,~/repos/plasma-workspace-wallpapers/Altai/contents/images/5120x2880.png
EOF
)

if [[ -f "$TERM_CONF_F" ]]; then
	before=$(grep "^#background-opacity" "$TERM_CONF_F")
	after=$(grep "^background-opacity" "$TERM_CONF_F")
	if [[ -n "$before" && -n "$after" ]]; then
		before="${before#\#}"
		after="#$after"
		tmp=$(mktemp)
		while IFS= read -r line; do
			case "$line" in
			\#background-opacity*) echo "$before" ;;
			background-opacity*) echo "$after" ;;
			*) echo "$line" ;;
			esac
		done <"$TERM_CONF_F" >"$tmp"
		mv "$tmp" "$TERM_CONF_F"
	else
		echo "$TERM_CONF_F does not have commented/non-commented before/after"
	fi
fi

if [[ -f "$WALLPAPER_CONF_F" ]]; then
	# check for first line of WALLPAPER_PRESENT
	if grep -qFx "$(head -1 <<<"$WALLPAPER_PRESENT")" "$WALLPAPER_CONF_F"; then
		while IFS= read -r line; do
			# `\` to use custom delimiter for address match
			sed -i "\|^$line|d" "$WALLPAPER_CONF_F"
		done <<<"$WALLPAPER_PRESENT"
		sed -i 's|^#||' "$WALLPAPER_CONF_F"
	else
		# replace the start of every line with a `#` (comment out every line)
		sed -i 's|^|#|' "$WALLPAPER_CONF_F"
		echo "$WALLPAPER_PRESENT" >>"$WALLPAPER_CONF_F"
	fi
	killall hyprpaper &>/dev/null || true
	# race between these two commands
	sleep 0.1
	nohup hyprpaper &>/dev/null || true &
	disown
fi

exit 0
