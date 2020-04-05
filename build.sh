#!/usr/bin/env bash

rm target/bootstrap*
bashing uberbash 
sed -i 's/^ *EOF$/EOF/g' ./target/bootstrap-*.sh 
cp ./target/bootstrap* ./target/bootstrap.sh 
