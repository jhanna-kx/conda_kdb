#!/bin/bash

for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" \
        "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done

KX=$RECIPE_DIR
# this seems a bit unreliable but SUBDIR only env variable could find in practice to distinguish between target_platform with conda build
QPY=q;
case $SUBDIR in
  #win-64)  # TODO
  # OSL='w'
  linux-64 | linux-arm64)
   OSL='l';;
  osx-64 | osx-arm64)
   OSL='m';;
esac

cp $KX/${OSL}64.zip .
unzip ${OSL}64.zip
mkdir -p $PREFIX/q/${OSL}64
mkdir $PREFIX/bin/
mv ${OSL}64/q $PREFIX/q/${OSL}64
mv q.k $PREFIX/q
cp ${RECIPE_DIR}/kc.lic.py $PREFIX/bin/q
chmod +x $PREFIX/bin/q
