#!/bin/bash
if ! command -v codeql &> /dev/null
then
    echo "Installing codeql cli"
    
    mkdir -p ~/Downloads && cd "$_"
        
    wget https://github.com/github/codeql-cli-binaries/releases/download/v2.12.3/codeql-linux64.zip

    mkdir -p ~/Documents/FlowMethod && cd "$_"

    unzip -o ~/Downloads/codeql-linux64.zip -d .

    echo -e "\n# CodeQL\nexport PATH=$PATH:$HOME/Documents/FlowMethod/codeql" >> ~/.bashrc
    
    codeql resolve languages
else
    mkdir -p ~/Documents/FlowMethod && cd "$_"
fi
