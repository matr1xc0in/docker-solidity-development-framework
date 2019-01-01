#!/bin/bash

CURR_DIR=$(cd $(dirname $0); pwd)

pushd $CURR_DIR

mkdir -p $CURR_DIR/deploy

docker run --rm -it \
  --mount type=bind,source=$CURR_DIR/deploy,target=/root/deploy \
  blcksync/docker-solidity-development-framework:latest

ret=$?

popd

exit $ret
