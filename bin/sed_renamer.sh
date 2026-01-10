#!/bin/bash
#
# Renames all files in the current directory that have a matching
# pattern in their file name, and replaces that pattern with a new
# pattern.
# For example, if there's many files like:
# blah_thisisathing1.txt blah_thisisathing2.txt etc
# you can rename these to:
# thing1.txt thing2.txt

if [ $# -ne 2 ] ; then
   echo "sed_renamer.sh <pattern> <replacement pattern>"
   exit 1
fi

pattern=$1
replacePattern=$2

for i in `ls | grep ${pattern}`
do
   newFile=$(echo "$i" | sed s/${pattern}/${replacePattern}/g)
   mv $i $newFile
   echo "$i ==> $newFile"
done