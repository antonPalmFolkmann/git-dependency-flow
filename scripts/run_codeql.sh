#!/bin/bash

cd /root/FlowMethod

echo "Creating database..."
cd target-repo
codeql database create ../database/ --language=python
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
codeql query run --database=./database --output=classes.bqrs -- source-repo/codeql-custom-queries-python/classes.ql
codeql query run --database=./database --output=constants.bqrs -- source-repo/codeql-custom-queries-python/constants.ql
codeql query run --database=./database --output=edges.bqrs -- source-repo/codeql-custom-queries-python/edges.ql
codeql query run --database=./database --output=functions.bqrs -- source-repo/codeql-custom-queries-python/functions.ql
codeql query run --database=./database --output=modules.bqrs -- source-repo/codeql-custom-queries-python/modules.ql
echo "Queries done"

echo "Decoding query ouput"
codeql bqrs decode --output=classes.csv --format=csv -- classes.bqrs
codeql bqrs decode --output=constants.csv --format=csv -- constants.bqrs
codeql bqrs decode --output=edges.csv --format=csv -- edges.bqrs
codeql bqrs decode --output=functions.csv --format=csv -- functions.bqrs
codeql bqrs decode --output=modules.csv --format=csv -- modules.bqrs
echo "Decoding done"
