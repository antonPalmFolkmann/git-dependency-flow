#!/bin/bash
if ! command -v codeql &> /dev/null
then
    echo "Installing codeql cli"
    if command -v brew &> /dev/null
    then
        brew install codeql
        mkdir -p $HOME/Documents/FlowMethod && cd "$_"
    else
        cd $HOME/Downloads
        wget https://github.com/github/codeql-cli-binaries/releases/download/v2.12.3/codeql-linux64.zip

        mkdir -p $HOME/Documents/FlowMethod && cd "$_"

        unzip -o $HOME/Downloads/codeql-linux64.zip -d .

        echo -e "\n# CodeQL\nexport PATH=$PATH:$HOME/Documents/FlowMethod/codeql" >> $HOME/.bashrc

        source $HOME/.bashrc
    fi
    
    echo "Verifying that codeql is installed properly"
    codeql --version
    codeql resolve languages
else
    mkdir -p $HOME/Documents/FlowMethod && cd "$_"
fi


echo "Cloning necessary git repositories"
git clone -q https://github.com/zeeguu/api.git target-repo
git clone -q https://github.com/github/vscode-codeql-starter.git source-repo
git clone -q https://github.com/antonPalmFolkmann/git-dependency-flow.git

echo "Creating database..."
cd target-repo
codeql database create ../database/ --language=python
cd ..
echo "Database created"

echo "Copying required files"
cp git-dependency-flow/flowmethod.ql source-repo/codeql-custom-queries-python/
cp git-dependency-flow/infomap-dictionary.py .


echo "Installing packs..."
cd source-repo/codeql-custom-queries-python
codeql pack install
cd ../..
echo "Packs installed"

echo "Running query"
codeql query run --database=./database --output=output.bqrs -- source-repo/codeql-custom-queries-python/flowmethod.ql

echo "Decoding query ouput"
codeql bqrs decode --output=decoded-results.csv --format=csv -- output.bqrs

echo "Done"
