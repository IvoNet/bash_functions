#!/usr/bin/env bash
###############################################################################
# Prepends a / to a path if not already there
#
# Usage:
#   # import this function
#   . ~/bin/bash_functions/slash.sh
#   # Call the function
#   local VARIABLE="$(pre_slash "path here")"
#   # now use the ${VARIABLE}
# See also the testcase
###############################################################################

pre_slash() {
   if [ ${1:0:1} == "/" ]; then
       echo $1
   else
       echo /$1
   fi
}

end_slash() {
   if [ ${1: -1} == "/" ]; then
       echo $1
   else
       echo $1/
   fi
}