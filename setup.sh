#!/bin/sh

TARGETDIR=${HOME}/bin

pushd $(dirname ${0}) > /dev/null

if [ ! -d ${HOME}/bin ]; then mkdir ${TARGETDIR}; fi

for i in $(ls *.*)
do
  fn=${i%.*}
  if [ $(basename ${i}) = $(basename ${0}) ]; then continue; fi
  if [ -h ${TARGETDIR}/${fn} ]; then
    echo "Remove current link : ${fn} on ${TARGETDIR}"
    rm -f ${TARGETDIR}/${fn}
  elif [ -e ${TARGETDIR}/${fn} ]; then
    echo "Exists and not replace : ${fn} on ${TARGETDIR}"
    continue
  fi
  ln -s $(pwd)/${i} ${TARGETDIR}/${fn}
  echo "Create link : ${fn} on ${TARGETDIR}"
done
