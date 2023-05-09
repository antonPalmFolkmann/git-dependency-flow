#!/bin/bash

cd /root/FlowMethod/git-dependency-flow

echo "Generating vertices and edges"
python3 flowmethod_trie.py

echo "Generating flowtree"
python3 infomap_graph.py

echo "ftree file generated"
echo "Done"
