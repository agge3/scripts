#!/usr/bin/env bash

set -eou pipefail

# dep check:
GRADLE_BIN=$(command -v gradle)
if [[ -z "$GRADLE_BIN" ]]; then
	echo "ERROR: gradle not found" >&2
	exit 1
fi

DISTRO=$(sed -n '/^NAME=/p' /etc/os-release | cut -d= -f2 | tr -d '"')

BIN_PATH="$HOME/.local/bin"

RL_PATH="$HOME/.local/opt/RuneLite"
RL_REPO="$RL_REPO/runelite"

# accounts to add to bin path
ACCOUNTS=(
	"agge_kun"
	"ironbsd"
)

GRADLE_WRAPPER="gradlew"
TARGET_JDK="openjdk-bin-11"

jdk_num() {
	if [[ $# -ne 1 || -z "$1" ]]; then
		return 1
	fi
	eselect java-vm list | grep "$1" | sed 's/.*\[\([0-9]*\)\].*/\1/'
}

# PRE: DISTRO is set
init() {
	if [[ "$DISTRO" == "Gentoo" ]]; then
		# set jvm version
		# tr because *sometimes* /etc/os-release has quotes around NAME
		PREV_JDK=$(eselect java-vm show | grep -A1 'user-vm' | tail -1 | tr -d ' ')
		PREV_NUM=$(jdk_num "$PREV_JDK")
		TARGET_NUM=$(jdk_num "$TARGET_JDK")
		if [[ -z "$PREV_NUM" || -z "$TARGET_NUM" ]]; then
			echo "FATAL: failed to get java-vm select numbers"
			exit 1
		fi
		eselect java-vm set user "$TARGET_NUM"
	fi

	echo "SUCCESS: init for DISTRO: $DISTRO"
}

# PRE: DISTRO is set
# PRE: DISTRO init was SUCCESS
cleanup() {
	if [[ "$DISTRO" == "Gentoo" ]]; then
		eselect java-vm set user "$PREV_NUM"
	fi
	echo "SUCCESS: cleanup for DISTRO: $DISTRO"
}

sed_inplace() {
	if [[ $(uname) == "Linux" ]]; then
		sed -i "$@"
	else
		sed -i '' "$@"
	fi
}

# main entry:
# xxx also handle other preconditions
if [[ ! -d "$BIN_PATH" ]]; then
	mkdir -pv "$BIN_PATH"
fi

init

trap 'cleanup' EXIT TERM INT QUIT

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

# use version to reference the built target
RL_JAR_PATTERN="client-$VERSION-shaded.jar"

git checkout "$LATEST_TAG" || true

# has broken plugin hub in the past (on master HEAD) - haven't tested on tags,
# but SAFE to do anyway to guarantee
sed_inplace "s/\${project.version}/$VERSION/" \
	runelite-client/src/main/resources/net/runelite/client/runelite.properties

./"$GRADLE_WRAPPER" clean
./"$GRADLE_WRAPPER" buildAll -x test

popd # root

# add runelite script with account postfix to bin path
for account in "${ACCOUNTS[@]}"; do
	ln -s "$RL_PATH/$account/runelite.sh" "$BIN_PATH/runelite-$account"
	ret=$?
	if [[ $ret -ne 0 ]]; then
		"ERROR: ln failed for account: $account. RET: $ret"
		# xxx should we exit, or let continue? since this is last output, it's
		# not clobbered easily, so we'll just continue
	fi
done

echo "DONE" 2>&1
exit 0
