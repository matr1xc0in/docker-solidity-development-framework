#!/bin/bash

curr_dir=$(cd $(dirname $0); pwd)

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD )

pushd $curr_dir

docker build \
  -t blcksync/docker-solidity-development-framework:$BRANCH_NAME \
  -f Dockerfile \
  .

ret=$?

popd

exit $ret
