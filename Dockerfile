FROM ubuntu:20.04

# silence debconf
ENV DEBIAN_FRONTEND=noninteractive

# update base packages
RUN apt-get update \
    && apt-get upgrade -y

# install sudo
RUN apt-get install -y sudo

# install nodejs
WORKDIR /opt
RUN apt-get install -y tar wget xz-utils
RUN wget --no-check-certificate https://nodejs.org/download/release/latest-v12.x/node-v12.19.0-linux-x64.tar.xz \
    && tar -axvf node-v12.19.0-linux-x64.tar.xz
RUN ln -s /opt/node-v12.19.0-linux-x64/bin/* /usr/local/bin/

# upgrade npm
RUN npm install npm@7.0.6 -g # CVE-2020-15095 / GHSA-xgh6-85xh-479p
RUN npm --version

# run testcase
WORKDIR /testcase
ADD package.json .
RUN npm run suid-enable
