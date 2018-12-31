#!/bin/bash

curr_dir=$(cd $(dirname $0); pwd)

pushd $curr_dir

docker build \
  -t blcksync/docker-solidity-development-framework:latest \
  -f Dockerfile \
  .

ret=$?

popd

exit $ret
