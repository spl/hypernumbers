#!/bin/sh                                                                       

DATE=`date +%Y-%m-%d.%T`

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export HOME=/home/hypernumbers/tests.hypernumbers.com
REPO=http://svn.arandomurl.com/hypernumbers/code/trunk
TESTDIR=hn_test_stage
LASTRUN=$HOME/test_results/last_run/

cd $HOME

svn co $REPO $HOME/$TESTDIR

cd $TESTDIR

./hypernumbers build
./hypernumbers gen_tests

cd priv/testserver

ruby regen_tests.rb 1x
ruby regen_tests.rb 2x

cd ../../

./hypernumbers test 1a
./hypernumbers test 1b
./hypernumbers test 1c
./hypernumbers test 1d
./hypernumbers test 1e
./hypernumbers test 1f
./hypernumbers test 2a
./hypernumbers test 2b
./hypernumbers test 2c
./hypernumbers test 2d
./hypernumbers test 2e
./hypernumbers test 2f
./hypernumbers test 2x
./hypernumbers test system_test

rm -rf $LASTRUN
mkdir $LASTRUN

cp -r logs/* $LASTRUN
cp logs/index.html $HOME/test_results/$DATE.html

rm -rf $HOME/$TESTDIR
