#!/bin/bash
if [ -f $LICDIR/kc.lic ]
then
 cp $LICDIR/kc.lic $QHOME
elif [ -f $LICDIR/k4.lic ]
then 
 cp $LICDIR/k4.lic $QHOME
else
 echo "No kc.lic/k4.lic" >&2
 exit 1
fi


$PREFIX/bin/q test.q -s 2 
