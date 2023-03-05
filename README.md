# git-dependency-flow

## Step 1: Install CodeQL CLI

```bash
# Go to downloads folder
cd $HOME/Downloads

# Getting codeQl from the internet
wget https://github.com/github/codeql-cli-binaries/releases/download/v2.12.3/codeql-linux64.zip

# Add target folder if it doesn't exist and cd to it
mkdir -p $HOME/Documents/FlowMethod && cd "$_"

# Unzip to target folder
unzip -o $HOME/Downloads/codeql-linux64.zip -d .

# Add path to .bashrc
echo -e "\n# CodeQL\nexport PATH=$PATH:$HOME/Documents/FlowMethod/codeql" >> $HOME/.bashrc

# Run source file to update changes to .bashrc
source $HOME/.bashrc

# verify that codeql is running properly
codeql --version
codeql resolve languages
```

With Homebrew:

```bash
brew install codeql

# verify that codeql is running properly
codeql --version
codeql resolve languages

mkdir -p $HOME/Documents/FlowMethod && cd "$_"
```

## Step 2: Clone target repository

```bash
# Codebase to be analyzed
git clone https://github.com/zeeguu/api.git target-repo
git clone https://github.com/github/vscode-codeql-starter.git source-repo
git clone https://github.com/antonPalmFolkmann/git-dependency-flow.git
```

## Step 3: Create database

```bash
cd target-repo
codeql database create ../database/ --language=python
cd ..
```

## Step 4: Copy files

```bash
cp git-dependency-flow/flowmethod.ql source-repo/codeql-custom-queries-python/
cp git-dependency-flow/infomap-dictionary.py .
```

## Step 5: Install packs

```bash
cd source-repo/codeql-custom-queries-python
codeql pack install
cd ../..
```

## Step 6: Run Query and Decode results

```bash
codeql query run --database=./database --output=output.bqrs -- source-repo/codeql-custom-queries-python/flowmethod.ql
codeql bqrs decode --output=decoded-results.csv --format=csv -- output.bqrs
```
