#!/bin/bash

cd /root/FlowMethod

echo "Cloning necessary git repositories..."

if [ ! -d "./source-repo/" ]
then
    git clone -q https://github.com/github/vscode-codeql-starter.git source-repo
fi

if [ ! -d "./git-dependency-flow/" ]
then
    git clone -q https://github.com/antonPalmFolkmann/git-dependency-flow.git
fi

cd git-dependency-flow
git checkout feature/prompt-git-url
cd ..

echo "Cloned git repositories"

read -p  "Input target GitHub repository URL: " target_repo_url

if [ ! -d "./target-repo/" ]
then
    git clone -q $target_repo_url target-repo
fi

