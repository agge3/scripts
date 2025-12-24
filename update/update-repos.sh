#!/usr/bin/env bash

# xxx actually put cfr in opt
OPT="$HOME/.local/opt"
REPOS="$HOME/repos"

pushd "$REPOS/cfr" || exit
# xxx branch?
git pull
mvn compile
popd || exit

pushd "$REPOS/groovy-language-server" || exit
# xxx java version
./gradlew build
cp "build/libs/groovy-language-server-all.jar" "$OPT/groovy-language-server"

# jdk11 doc:
# https://www.oracle.com/java/technologies/javase-jdk11-doc-downloads.html#license-lightbox
# unzip ${docs}.zip -d ${docs}
# mv ${docs} ~/docs
# ln -s ~/docs/${docs}/docs /opt/openjdk-bin-11/docs
