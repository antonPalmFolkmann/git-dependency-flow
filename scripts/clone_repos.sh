#!/bin/bash

cd /root/FlowMethod

echo "Cloning necessary git repositories..."

if [ ! -d "./git-dependency-flow/" ]
then
    git clone -q https://github.com/antonPalmFolkmann/git-dependency-flow.git
fi

echo "Installing packs..."
cd git-dependency-flow/queries
codeql pack install
echo "Packs installed"

echo "Cloned git repositories"



