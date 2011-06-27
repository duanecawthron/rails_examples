#!/bin/bash

TOP=`dirname $0`
[ "$TOP" = "." ] && TOP=`pwd`
cd $TOP/..
TOP=`pwd`

[ -d scripts ]  || { echo ERROR: cannot find scripts in `pwd`; exit 1; }

mkdir -p download
cd download

[ -f jquery.tmpl.js ] || \
wget --no-verbose http://ajax.aspnetcdn.com/ajax/jquery.templates/beta1/jquery.tmpl.js
