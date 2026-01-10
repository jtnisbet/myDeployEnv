#!/bin/bash

#################################################################################
#  Name:        msgFmt.sh                                                       #
#                                                                               #
#  Description: Bash shell functionality to diplay messages for use with runCmd #
#               script but can also be used directly by sourcing it.            #
#                                                                               #
#               There's 4 functions here:                                       #
#               msgEnter                                                        #
#               msgOk                                                           #
#               msgFail                                                         #
#               msgError                                                        #
#                                                                               #
#               These 4 functions are used when you have a bigger piece of      #
#               logic that you want to wrap the look-and-feel messaging around  #
#               it                                                              #
#  Example:     
#               #!/bin/bash                                                     #
#               source msgFmt.sh                                                #
#               msgEnter "Running some code here"                               #
#               rc=$(someCode)                                                  #
#               if [ $rc -eq 0 ] ; then                                         #
#                  msgOK "OK"                                                   #
#               else                                                            #
#                  msgFail "FAILED"                                             #
#                  msgError "Something failed" "{$rc}" "/tmp/errorLog.out"      #
#               fi                   
#################################################################################

#################################################################################
#  Function: msgEnter                                                           #
#  Description: Display the leading text before entering a block of logic.      #
#################################################################################
msgEnter()
{
   printf "%-60s : " "${1}"        
}

#################################################################################
#  Function: msgOK                                                              #
#  Description: Display the okay message.                                       #
#################################################################################
msgOK()
{
   echo -e '\E[32m'"\033[1m$1\033[0m"
}

#################################################################################
#  Function: msgFail                                                            #
#  Description: Display the fail message.                                       #
#################################################################################
msgFail()
{
   echo -e '\E[31m'"\033[1m$1\033[0m"
}

#################################################################################
#  Function: msgError                                                           #
#  Description: If something is not successful, display some info about it      #
#                                                                               #
#  Arguments are optional with defaults.  You should pass empty string for any  #
#  args not being used so that it chooses the defaults.                         #
#                                                                               #
#  Optional arguments:  arg 1: An error message.                                #
#                                                                               #
#                       arg 2: The return code.                                 #
#                                                                               #
#                       arg 3: An error file to scan.  Shows the last 5 lines   #
#                              from this file which usually would have any      #
#                              error messages in there.                         #
#################################################################################
msgError()
{
   msg=${1:-none}
   errRc=${2:-none}
   errFile=${3:-none}

   # Next, display any optional args that may have been given
   
   if [ "${msg}" != "none" ] ; then
      echo "${msg}"
   fi

   if [ "${errRc}" != "none" ] ; then
      echo "Return code: ${errRc}"
   fi

   if [ "${errFile}" != "none" ] ; then
      # TODO: make a nicer output for displaying error files.  for example maybe
      # indent it, word wrap or truncate, etc
      echo "Text from output:"
      tail -5 ${errFile}
   fi
}
