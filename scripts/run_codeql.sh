#!/bin/bash

cd /root/FlowMethod

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
