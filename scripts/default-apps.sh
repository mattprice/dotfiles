#!/usr/bin/env bash

# This script is based around a tool called Duti which is installed via Brew
# https://github.com/moretension/duti

if [[ $(uname -s) != 'Darwin' ]]; then
  echo '^ Skipped because platform is not macOS.'
  exit 0
fi

# Set default app for file extensions
for ext in c cc css h js jsx json md php rb scss sh tf ts tsx txt xml yaml yml; do
  duti -s dev.zed.Zed "$ext" all
done
