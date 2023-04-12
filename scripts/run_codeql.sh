#!/bin/bash

cd /root/FlowMethod

echo "Creating database..."
cd target-repo
codeql database create --language=python --quiet ../database/ 
cd ..
echo "Database created"

echo "Copying required files"
cp git-dependency-flow/queries/. source-repo/codeql-custom-queries-python/ -r

echo "Installing packs..."
cd source-repo/codeql-custom-queries-python
codeql pack install
cd ../..
echo "Packs installed"

echo "Running queries"
codeql query run --database=./database --output=git-dependency-flow/raw/classes.bqrs -- source-repo/codeql-custom-queries-python/classes.ql
codeql query run --database=./database --output=git-dependency-flow/raw/constants.bqrs -- source-repo/codeql-custom-queries-python/constants.ql
codeql query run --database=./database --output=git-dependency-flow/raw/edges.bqrs -- source-repo/codeql-custom-queries-python/edges.ql
codeql query run --database=./database --output=git-dependency-flow/raw/functions.bqrs -- source-repo/codeql-custom-queries-python/functions.ql
codeql query run --database=./database --output=git-dependency-flow/raw/modules.bqrs -- source-repo/codeql-custom-queries-python/modules.ql
echo "Queries done"

echo "Decoding query output"
codeql bqrs decode --output=git-dependency-flow/data/classes.csv --format=csv -- git-dependency-flow/raw/classes.bqrs
codeql bqrs decode --output=git-dependency-flow/data/constants.csv --format=csv -- git-dependency-flow/raw/constants.bqrs
codeql bqrs decode --output=git-dependency-flow/data/edges.csv --format=csv -- git-dependency-flow/raw/edges.bqrs
codeql bqrs decode --output=git-dependency-flow/data/functions.csv --format=csv -- git-dependency-flow/raw/functions.bqrs
codeql bqrs decode --output=git-dependency-flow/data/modules.csv --format=csv -- git-dependency-flow/raw/modules.bqrs
echo "Decoding done"
