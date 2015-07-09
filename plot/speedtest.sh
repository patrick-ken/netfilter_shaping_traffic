#!/bin/bash
rm values.txt
touch values.txt
while true
do
wget -O /dev/null 'http://www.youtube.com/' 2>&1 | grep -o '\([0123456789]\+ [KM]*B/s\)' >> values.txt;
done;
