#!/bin/bash
# lists files with full path names ordered by file size.
# useful for finding big files when you are asked to clean up disk usage.
# only showing top 40 here

ls -lSR | awk '
BEGIN {
   fm="%-15s %s%s\n"
   pathStart="."
}
{
   # if the first character is a dot then this line is the path name
   # otherwise it is a file so capture the details and print
   # if the line is empty do nothing
   if (index($0,pathStart) == 1)
   {
      currPath=$1
   }
   else if (length($0) != 0)
   {
      printf fm, $5, currPath, $9
   }
}' | sed 's|\:|\/|g' | sort -rn | head -40

# The sed command changes the colon to a / because the path name from ls ends in a colon
# and when we go to add the filename after the path we don't want that colon there.
