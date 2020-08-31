#!/usr/bin/env bash
workdir=$(pwd)
cd $workdir
## The next repo correspond to the latest release of Nuwro, forked from @DmitryZhuridov on 25/08/2020
git clone https://github.com/gapalacic/nuwro-1.git
mkdir install
cd $workdir/install
#dowload pythia6 sources
wget https://root.cern.ch/download/pythia6.tar.gz
tar xzf pythia6.tar.gz
cd pythia6
#modify ./makePythia6.linux to use gfortran in place of g77
sed -i 's/g77/gfortran/g' ./makePythia6.linux
#make libPythia6.so
bash ./makePythia6.linux
#download ROOT sources
cd $workdir/install
wget https://root.cern/download/root_v6.16.00.source.tar.gz
tar zxf root_v6.16.00.source.tar.gz
cd $workdir
#create build directory
mkdir $workdir/programs
mkdir $workdir/programs/root
mkdir $workdir/programs/root/lib
#copy pythia6 library to build directory
cp $workdir/install/pythia6/libPythia6.so  $workdir/programs/root/lib
cd $workdir/programs/root/
#cmake ROOT with PYTHIA6 enabled
cmake -DPYTHIA6_LIBRARY=$workdir/programs/root/lib/libPythia6.so -Dpyhia6=ON $workdir/install/root-6.16.00
#make it
make -j2
cd $workdir/nuwro-1
source $workdir/programs/root/bin/thisroot.sh ## Execute the last two lines manually
make
