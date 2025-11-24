#!/usr/bin/env bash

rl_dir="$HOME/.local/opt/RuneLite/runelite"
url="https://api.github.com/repos/runelite/runelite/tags"

latest() {
	curl -s "$url" | jq -r '.[0].name' | awk -F- '{print $NF}'
}

ver=$(latest)
if [[ -z "$ver" ]]; then
	echo "parse_latest failed"
	exit 1
fi

echo "version: $ver"

cd "$rl_dir"
git fetch --all
git reset --hard origin/master
git clean -xdf

sed -i "s/\${project.version}/$ver/g"	\
runelite-client/src/main/resources/net/runelite/client/runelite.properties
mvn clean install -DskipTests=true
