#!/usr/bin/env bash

mkdir -p target
rm target/bootstrap*
bashing uberbash 
sed -i 's/^ *EOF$/EOF/g' ./target/bootstrap-*.sh 
cp ./target/bootstrap* ./target/bootstrap.sh 
REMOTE="$(git remote -v | grep fetch | cut -b 27- | sed 's/\.git .*//')"
sed -i "s@raw.githubusercontent.com/.*@raw.githubusercontent.com/$REMOTE/master/target/bootstrap.sh@g" README.md