#!/bin/bash

cd /root/FlowMethod

read -p  "Input target GitHub repository URL: " target_repo_url

if [ ! -d "./target-repo/" ]
then
    git clone -q $target_repo_url target-repo
fi

cd ../scripts

./run_codeql.sh
./generate_flowtree.sh
