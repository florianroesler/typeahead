#!/bin/bash
shards check
if [ "$?" != 0 ]; then
  echo "Installing Shards"
  shards install
fi

crystal run sentry.cr
