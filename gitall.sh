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
