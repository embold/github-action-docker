#!/bin/sh -l

if [ "$#" -ne 5 ]; then
  /embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4} -sh /embold/corona
else
  echo "Using verbose mode"
  /embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4}  -v -sh /embold/corona  
fi
