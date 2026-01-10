#!/bin/bash
#
# Simple script to validate if the tools/software that I like to use are installed or not (or not in PATH)
#

checkCmd()
{
    cmdName=$1
    command -v ${cmdName} > /dev/null 2>&1
    rc=$?
    if [ ${rc} -ne 0 ] ; then
        echo "${cmdName} does not appear to be installed or not in PATH env."
    else
        echo "${cmdName} is installed."
    fi
}

echo "Checking if tools I like to use are installed and in PATH"
echo "If not, you may want to address that by installing them and/or ensuring they can be found in PATH"
echo
cmdList="gdb emacs xterm g++ gcc javac go"

for i in ${cmdList}
do
    checkCmd $i
done

