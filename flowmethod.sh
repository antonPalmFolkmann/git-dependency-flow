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

echo "Creating database..."
cd target-repo
codeql database create ../database/ --language=python
cd ..
echo "Database created"

echo "Copying required files"
cp git-dependency-flow/edges.ql source-repo/codeql-custom-queries-python/
cp git-dependency-flow/vertices.ql source-repo/codeql-custom-queries-python/
cp git-dependency-flow/infomap-dictionary.py .


echo "Installing packs..."
cd source-repo/codeql-custom-queries-python
codeql pack install
cd ../..
echo "Packs installed"

echo "Running queries"
codeql query run --database=./database --output=edges.bqrs -- source-repo/codeql-custom-queries-python/edges.ql
codeql query run --database=./database --output=vertices.bqrs -- source-repo/codeql-custom-queries-python/vertices.ql

echo "Decoding query ouput"
codeql bqrs decode --output=edges.csv --format=csv -- edges.bqrs
codeql bqrs decode --output=vertices.csv --format=csv -- vertices.bqrs
echo "Decoding done"

echo "Generating vertices and edges"
python3 infomap-dictionary.py

echo "Generating ftree file"
if ! command -v infomap &> /dev/null
then
	pip install infomap
fi

infomap --node-limit 1000 --ftree -d pajek.txt .
echo "ftree file generated"
echo "Done"
