# docker-solidity-development-framework
A docker images to encapsulate all necessary development tools for Solidity development with Truffle framework.
This includes all necessary toolings for any usres to download, configure, and deploy their solidity contract
and make it easy for anyone to use as our goal.

## To build your docker image
```
./build.sh
```

## To run the docker image
```
./run.sh
```

**A local directory ./deploy will be created and mounted into your docker container**.
This preserves the work you create in the container so it doesn't get deleted/wiped out when
you exist the container. Make sure you are working under the `/go/deploy` directory.

After you run it, a command prompt will show up, now, you can simply run the `truffle` command
as you like, e.g.
```
cd deploy
mkdir myfirst_project
cd myfirst_project
truffle init
truffle compile
truffle test
# truffle migrate
```

or from a pre-built box provided by the community, e.g. Metacoin https://truffleframework.com/boxes/metacoin
```
cd deploy
mkdir metacoin
cd metacoin
truffle unbox metacoin
truffle compile
truffle test
# truffle migrate
```

Truffle migrate will not work unless you provide a local [ganache-cli](https://github.com/trufflesuite/ganache-cli)
or use [Infura](https://truffleframework.com/tutorials/using-infura-custom-provider).
