#!/usr/bin/env bash

# xxx actually put cfr in opt
LOCAL_OPT="$HOME/.local/opt"
LOCAL_BIN="$HOME/.local/bin"
REPOS="$HOME/repos"

# nop if already exists
mkdir -pv "$LOCAL_OPT"
mkdir -pv "$LOCAL_BIN"

pushd "$REPOS/cfr" || exit
# xxx branch?
git pull
mvn compile
popd || exit

pushd "$REPOS/groovy-language-server" || exit
# xxx java version
./gradlew build
cp "build/libs/groovy-language-server-all.jar" "$LOCAL_OPT/groovy-language-server"

# jdk11 doc:
# https://www.oracle.com/java/technologies/javase-jdk11-doc-downloads.html#license-lightbox
# unzip ${docs}.zip -d ${docs}
# mv ${docs} ~/docs
# ln -s ~/docs/${docs}/docs /opt/openjdk-bin-11/docs

# XXX MIGRATE ALL THE ABOVE TO ~/.local/opt

### git-xet ###
BIN_NAME="git-xet"

# update
git fetch --all && git pull origin main

# build
pushd "$LOCAL_OPT/xet-core/git_xet" || exit
cargo build --release
popd || exit

ln -sfn "$LOCAL_OPT/target/release/$BIN_NAME" "$LOCAL_BIN/$BIN_NAME"
