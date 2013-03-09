#!/bin/bash
# Author: Michael Gilliland, Purpose: to automate commits to some degree

if [ -f tools.cfg ];then 
  . tools.cfg
  git add -A $project_root
  echo "Git message:"
  read message

  git commit -m "$message"
  git push
else
  echo "No configuration file found"
fi
