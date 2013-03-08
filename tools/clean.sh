#!/bin/bash
# Author: Michael Gilliland, Purpose: cleans out any files with to_remove
# as extension

to_remove="pyc swp"

for clean_name in $to_remove; do
  echo "Attempting to clean $clean_name files"
  found=$(find .. -name "*.$clean_name")

  if [ exists $found ]; then
    echo "-> Found no $clean_name files"
  else
    echo "-> Found some $clean_name files"
    echo "-> Removing:"
    echo "$found"
    echo $found | xargs rm
  fi
done
