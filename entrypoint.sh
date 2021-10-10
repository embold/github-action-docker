#!/bin/sh -l

if [[ -n ${5} ]]; then
  echo "using verbose mode"
  /embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4}  -v -sh /embold/corona
else
  echo "NOT using verbose mode"
  /embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4} -sh /embold/corona
fi
