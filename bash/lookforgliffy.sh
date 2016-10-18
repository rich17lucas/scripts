#!/bin/bash
#
################################################################################
# Name:     lookforgliffy.sh
# Author:   Richard Lucas
#
# Useage:  lookforgliffy.sh <file> 
#
# Use in conjunction with this 'find' command:
# find . -type f -exec ~/workspace/scripts/bash/examining_files/lookforgliffy.sh {} \; | grep -c gliffy
#
# Function: Looks for Gliffy files in the given file by:
#   using 'file' to see if the file is a zip
#       if it contains a file called 'properties.json'
#           extract it to stdout 
#               grep for 'gliffy'
#                   increment gliffy count
#   print gliffy count
################################################################################
#
# 
# TODO Check that a file is given
myfile=$1
#echo "DEBUG $myfile"

# main ()
# Check if the file is a zip file
res=$(file ${myfile} )

if [[ ${res} =~ 'Zip archive data' ]]; then
    echo "${myfile} is a zip file"
    # Check if it contains a file named 'properties.json' that contains gliffy
    res=$(unzip -c "${myfile}" properties.json 2>/dev/null | grep "gliffy")
    if [[ ${res} =~ "gliffy" ]]; then
        echo "And it contains a gliffy !!"
    fi
else 
    echo "${myfile} is not a zip file"
fi
