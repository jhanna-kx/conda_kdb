#!/bin/bash
function licexist(){
 if [ -f $1/kc.lic ] || [ -f $1/k4.lic ]
 then
  export LICDIR=$1
 else
  echo "k4.lic/kc.lic not found in: $1" >&2
  exit 1
 fi
 }
if [ "x" != "x$LICDIR" ]
then
 licexist $LICDIR
else
 if [ "x" != "x$QLIC" ]
 then
  licexist $QLIC
 elif [ "x" != "x$QHOME" ]
 then
  licexist $QHOME
 else
  licexist .
 fi
fi
if [ $(uname) == "Linux" ]
then 
 OSL=l
elif [ $(uname) == "Darwin" ]
then
 OSL=m
else
 echo "unknown os $(uname)" >&2
 exit 1
fi

KDBZIP=${OSL}64.zip
if [ ! -f $KDBZIP ]
then
 echo "kdb zip file $KDBZIP not found" >&2
 exit 1
fi
unzip -o $KDBZIP
echo $LICDIR 
export QHOME=$(pwd)
export QLIC=$LICDIR
QBUILD=$(echo .z.k|${OSL}64/q -q)
export QBUILD

conda build --croot /tmp --no-long-test-prefix --no-include-recipe .




   
