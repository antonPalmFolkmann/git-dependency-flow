#!/bin/bash

cd /root/FlowMethod

echo "Cloning necessary git repositories..."
if [ ! -d "./target-repo/" ]
then
    git clone -q https://github.com/zeeguu/api.git target-repo
fi

if [ ! -d "./source-repo/" ]
then
    git clone -q https://github.com/github/vscode-codeql-starter.git source-repo
fi

if [ ! -d "./git-dependency-flow/" ]
then
    git clone -q https://github.com/antonPalmFolkmann/git-dependency-flow.git
fi
echo "Cloned git repositories"

echo "Checkout to correct branch"
cd git-dependency-flow/
git checkout feature/trie-construction
cd ..
