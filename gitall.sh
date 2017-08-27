#!/bin/sh

#############################
### 2016/12/17 : Create
#############################

# variables
GLIST=${HOME}/.gitall_list

# checking arguments
if [ "${1}" = "" ]; then
  echo "Need some arguments."
  git help
  exit
fi

# adding pwd to list file ($1: addlist)
if [ "${1}" = "addlist" ]; then
  echo $(pwd) >> ${GLIST}
  exit
fi
  
# checking list file existence
if [ ! -f ${GLIST} ]; then
  echo "No list file. Make listfile first. (use \"gitall addlist\")"
  exit
fi

# show list file ($1: showlist)
if [ "${1}" = "showlist" ]; then
  inc=1
  for i in $(cat ${GLIST})
  do
    echo ${inc} : ${i}
    inc=$((${inc}+1))
  done
  exit
fi

# list file ($1: pushd)
# it doesn't work well by itself. use "source"/"." command when using this option.
if [ "${1}" = "pushd" ]; then
  inc=1
  for i in $(cat ${GLIST})
  do
    if [ "${2}" = "${inc}" ]; then
      pushd ${i}
      return 0 2> /dev/null
      echo "use 'source' command when use this option."
      exit
    fi
    inc=$((${inc}+1))
  done
  echo "can't find such a number '${2}'. try another one!"
  return 1 2> /dev/null
  echo "use 'source' command when use this option."
  exit
fi

# move to each directory and do command
for i in $(cat ${GLIST})
do
  pushd ${i} > /dev/null
  if [ "${r}" != "a" ]; then r="t"; fi
  echo "*** path : ${i} *** (git ${@})"
  while [ "${r}" != "a" -a "${r}" != "y" -a "${r}" != "n" ]
  do
    echo "choose [yna] : "
    read -n 1 r
    echo ""
  done
  if [ "${r}" != "n" ]; then
    git ${@}
    echo " "
  fi
  popd > /dev/null
done
