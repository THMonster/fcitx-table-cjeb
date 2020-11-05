#!/bin/sh
OLDIFS=$IFS;IFS=$'\n\n'
for line in `cat $1`
do
    line=`echo ${line} | sed 's/\(.\+\) \(.\+\)/\2\t\1/g'`
    echo ${line}
done
