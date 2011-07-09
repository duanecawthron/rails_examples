#!/bin/bash

TOP=`dirname $0`
[ "$TOP" = "." ] && TOP=`pwd`
cd $TOP/..
TOP=`pwd`

[ -d scripts ]  || { echo ERROR: cannot find scripts in `pwd`; exit 1; }

mkdir -p download
cd download

[ -d kaminari ] || git clone https://github.com/amatsuda/kaminari.git
