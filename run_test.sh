#!/bin/bash
if [ -f $QLIC/kc.lic ]
then
 cp $QLIC/kc.lic $QHOME
elif [ -f $QLIC/k4.lic ]
then 
 cp $QLIC/k4.lic $QHOME
else
 echo "No kc.lic/k4.lic" >&2
 exit 1
fi


$PREFIX/bin/q test.q -s 2 
