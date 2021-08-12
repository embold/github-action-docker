#!/bin/sh -l

echo $GITHUB_WORKSPACE
var=$(ls $GITHUB_WORKSPACE)
echo $var
/embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4}  -sh /embold/corona
