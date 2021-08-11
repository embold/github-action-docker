#!/bin/sh -l

ls /github/workspace
/embold/scanner/bin/embold-scanner -u ${1} -t ${2} -c ${3} -r ${4}  -sh /embold/corona
