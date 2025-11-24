#!/usr/bin/env bash
# disk-hotspots.sh — Deep disk usage analyzer
# Shows top directories, top files, and per-subtree breakdowns

# CREDIT: OpenAI's ChatGPT
# reviewed to be SAFE by agge3

set -euo pipefail

TARGET_DIR="${1:-/}"
DEPTH="${2:-3}" # configurable directory depth

echo "🔍 Analyzing disk usage starting from: $TARGET_DIR"
echo "📏 Directory depth: $DEPTH"
echo

# 1️⃣ Overview of mounted filesystems
echo "=== Filesystem usage ==="
df -h --total | awk 'NR==1 || /total/ || $NF == "/" || $NF == "/home" || $NF == "/var"'
echo

# 2️⃣ Top 30 directories by total size
echo "=== Top 30 directories (depth $DEPTH) ==="
sudo du -h --max-depth="$DEPTH" "$TARGET_DIR" 2>/dev/null |
	sort -hr | head -n 30
echo

# 3️⃣ Top 30 largest files
echo "=== Top 30 largest files ==="
sudo find "$TARGET_DIR" -xdev -type f -printf '%s %p\n' 2>/dev/null |
	sort -nr | head -n 30 |
	awk '{ printf "%10.2f MB  %s\n", $1/1024/1024, $2 }'
echo

# 4️⃣ Section: Common heavy directories
for dir in /var /home /usr /tmp /opt /root; do
	if [ -d "$dir" ]; then
		echo "=== Breakdown for $dir ==="
		sudo du -h --max-depth=2 "$dir" 2>/dev/null | sort -hr | head -n 15
		echo
	fi
done

# 5️⃣ Docker and Podman data (if any)
if [ -d /var/lib/docker ]; then
	echo "=== Docker storage ==="
	docker system df || true
	echo
	sudo du -h --max-depth=2 /var/lib/docker 2>/dev/null | sort -hr | head -n 15
	echo
fi

if [ -d /var/lib/containers ]; then
	echo "=== Podman storage ==="
	sudo du -h --max-depth=2 /var/lib/containers 2>/dev/null | sort -hr | head -n 15
	echo
fi

# 6️⃣ Logs section
if [ -d /var/log ]; then
	echo "=== Largest log files ==="
	sudo find /var/log -type f -printf '%s %p\n' 2>/dev/null |
		sort -nr | head -n 20 |
		awk '{ printf "%10.2f MB  %s\n", $1/1024/1024, $2 }'
	echo
fi

# 7️⃣ Human summary
echo "=== Summary of biggest space hogs ==="
du -h --max-depth=1 "$TARGET_DIR" 2>/dev/null | sort -hr | head -n 20
echo

echo "✅ Done. Consider reviewing Docker volumes, /var/log, and /usr/src for cleanup."
