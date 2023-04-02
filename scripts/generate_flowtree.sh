#!/bin/bash

cd /root/FlowMethod/git-dependency-flow

echo "Generating vertices and edges"
python3 flowmethod_trie.py
python3 infomap_dictionary.py

echo "Generating ftree file"
if ! command -v infomap &> /dev/null
then
	pip install infomap
fi

infomap --node-limit 1000 --ftree -d pajek.txt .
echo "ftree file generated"
echo "Done"
