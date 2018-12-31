FROM blcksync/go11-node:latest as builder

LABEL maintainer="alee-blocksync"

ENV SHELL=/bin/bash \
    GOPATH=/go

COPY package.json /go/package.json
COPY package-lock.json /go/package-lock.json

RUN mkdir -p /go/bin; cd /go; \
    apk update && apk upgrade && \
    apk add --no-cache bash git \
    busybox-extras \
    python \
    python-dev \
    py-pip \
    libtool \
    autoconf \
    automake \
    build-base \
    make gcc musl-dev linux-headers \
    ca-certificates \
    python2 \
    py-setuptools \
    && rm -rf /var/cache/apk/* \
    && if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi \
    && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi \
    && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi ; \
    npm install -g node-gyp@3.8.0 && npm install --python=/usr/bin/python && \
    npm install -g truffle@4.1.15 solc@0.4.25 truffle-hdwallet-provider@0.0.6 js-sha256@0.9.0 bignumber@1.1.0 crypto-js@3.1.9-1; \
    mkdir /go/deploy

FROM blcksync/go11-node:latest

LABEL maintainer="alee-blocksync"

ENV SHELL=/bin/bash \
    GOPATH=/go

USER root
WORKDIR /root

RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates bash git busybox-extras && \
    rm -rf /var/cache/apk/* && \
    echo "export PATH=/usr/local/go/bin:\$GOPATH/bin:\$PATH:\$HOME/bin" > /etc/profile.d/go_path.sh

COPY --from=builder /usr/local/go/bin/* /usr/local/go/bin/
COPY --from=builder /usr/lib/node_modules /usr/lib/
COPY --from=builder /root/.npm /root/.npm
COPY --from=builder /root/.node-gyp /root/.node-gyp
COPY --from=builder /root/.config /root/
COPY --from=builder /go/* /go/

CMD ["bash"]
