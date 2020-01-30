#!/bin/sh

oldip=$1
newip=$2

sed -i -e 's/'$oldip'\b/'$newip'/g' streamingserver.xml

cat streamingserver.xml | grep $newip
