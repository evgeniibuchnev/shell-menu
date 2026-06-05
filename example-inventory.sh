#!/usr/bin/env bash
# Example inventory script: outputs a newline-separated list of hosts for use with shell-menu

LIST="webserver01 webserver02 webserver03"
for HOST in $LIST; do
  echo $HOST
done
