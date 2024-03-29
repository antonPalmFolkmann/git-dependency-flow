#!/bin/bash

cd /root/FlowMethod

echo "Creating database..."
cd target-repo
codeql database create --language=python --quiet ../database/ 
cd ..
echo "Database created"

echo "Running queries"
codeql query run --database=./database --output=git-dependency-flow/raw/classes.bqrs -- git-dependency-flow/queries/classes.ql
codeql query run --database=./database --output=git-dependency-flow/raw/constants.bqrs -- git-dependency-flow/queries/constants.ql
codeql query run --database=./database --output=git-dependency-flow/raw/edges.bqrs -- git-dependency-flow/queries/edges.ql
codeql query run --database=./database --output=git-dependency-flow/raw/functions.bqrs -- git-dependency-flow/queries/functions.ql
codeql query run --database=./database --output=git-dependency-flow/raw/modules.bqrs -- git-dependency-flow/queries/modules.ql
echo "Queries done"

echo "Decoding query output"
codeql bqrs decode --output=git-dependency-flow/data/classes.csv --format=csv -- git-dependency-flow/raw/classes.bqrs
codeql bqrs decode --output=git-dependency-flow/data/constants.csv --format=csv -- git-dependency-flow/raw/constants.bqrs
codeql bqrs decode --output=git-dependency-flow/data/edges.csv --format=csv -- git-dependency-flow/raw/edges.bqrs
codeql bqrs decode --output=git-dependency-flow/data/functions.csv --format=csv -- git-dependency-flow/raw/functions.bqrs
codeql bqrs decode --output=git-dependency-flow/data/modules.csv --format=csv -- git-dependency-flow/raw/modules.bqrs
echo "Decoding done"
