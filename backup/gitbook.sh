#!/bin/bash

cd /opt/soft/gitbook
rm -rf xl-lighthouse-doc
git clone https://github.com/xl-xueling/xl-lighthouse-doc.git
mkdir -p ./target
rm -rf ./target/*
cp -r xl-lighthouse-doc/* ./target
cd /opt/soft/gitbook/target
gitbook install
gitbook build
ps aux|grep node|grep -v grep | awk '{print $2}' |xargs --no-run-if-empty kill -9
