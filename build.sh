#!/bin/bash

for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" \
        "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done

KX=$RECIPE_DIR
if [ `uname` == Linux ]; then
    OSL='l'
fi
if [ `uname` == Darwin ]; then
    OSL='m'
fi

cp $KX/${OSL}64.zip .
unzip ${OSL}64.zip
mkdir -p $PREFIX/q/${OSL}64
mv ${OSL}64/q $PREFIX/q/${OSL}64
mv q.k $PREFIX/q
cp ${RECIPE_DIR}/kc.lic.py $PREFIX/bin/q
chmod +x $PREFIX/bin/q
