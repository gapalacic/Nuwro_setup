#!/usr/bin/env bash
workdir=$(pwd)
cd $workdir
mkdir root_v6
cd $workdir
###
wget https://root.cern/download/root_v6.24.02.source.tar.gz
tar zxf root_v6.24.02.source.tar.gz
cd $workdir/root_v6
cmake -$workdir/root-6.24.02
make -j2
