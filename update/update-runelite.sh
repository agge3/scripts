#!/usr/bin/env bash

set -eoux pipefail

GRADLE_BIN=$(command -v gradle)
if [[ -z "$GRADLE_BIN" ]]; then
	echo "ERROR: gradle not found" >&2
	exit 1
fi

JDK_RELEASE="openjdk-bin-11"

# set jvm version
DISTRO=$(sed 's/NAME=.*/p' /etc/os-release | cut -d= -f2)
if [[ "$DISTRO" == "Gentoo" ]]; then
	NUM=$(eselect java-vm list | grep "$JDK_RELEASE" | sed 's/.*\[\([0-9]*\)\].*/\1/')
	eselect java-vm set "$NUM"
fi

sed_inplace() {
	if [[ $(uname) == "Linux" ]]; then
		sed -i "$@"
	else
		sed -i '' "$@"
	fi
}

RL_REPO="$HOME/.local/opt/RuneLite/runelite"

pushd "$RL_REPO" || exit
echo "DEBUG: cwd: $(pwd)"

# reset to master HEAD for the newest version and cleanup repo of any previous
# artifacts
git fetch --all
git reset --hard origin/master
git clean -xdf

TAGS=$(git tag --sort=-version:refname)
if [[ -z "$TAGS" ]]; then
	echo "ERROR: failed to git tag" >&2
fi
echo "DEBUG: TAGS: $TAGS" 2>&1

# XXX pipefail when `git tag | head` - because of less???

LATEST_TAG=$(echo "$TAGS" | head -n 1)
if [[ -z "$LATEST_TAG" ]]; then
	echo "ERROR: failed to split latest tag" >&2
	exit 1
fi
echo "DEBUG: LATEST_TAG: $LATEST_TAG" 2>&1

VERSION=$(echo "$LATEST_TAG" | awk -F- '{print $NF}')
echo "DEBUG: VERSION: $VERSION" 2>&1
if [[ -z "$VERSION" ]]; then
	echo "ERROR: failed to strip version" >&2
	exit 1
fi

git checkout "$LATEST_TAG" || true

# has broken plugin hub in the past (on master HEAD) - haven't tested on tags,
# but SAFE to do anyway to guarantee
sed_inplace "s/\${project.version}/$VERSION/" \
	runelite-client/src/main/resources/net/runelite/client/runelite.properties

"$GRADLE_BIN" clean buildAll -x test

popd # root

# distribute built runelite in release
# use version to reference the built target
RL_JAR_PATTERN="client-$VERSION-shaded.jar"

# update root build.gradle to reflect newest runelite version
sed_inplace "s/def runeLiteVersion.*/def runeLiteVersion = '$VERSION'/" \
	build.gradle

echo "DONE" 2>&1
exit 0
