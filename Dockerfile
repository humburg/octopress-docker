FROM ubuntu:16.04

MAINTAINER Peter Humburg <peter.humburg@gmail.com>

ENV LC_ALL C.UTF-8

# Get dependencies
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442 && \
  echo 'deb http://download.fpcomplete.com/ubuntu xenial main'| tee /etc/apt/sources.list.d/fpco.list && \
  apt-get update && apt-get install -y \
  texlive-xetex \
  bundler \
  curl \
  git \
  ruby \
  stack \
  wget && \
  apt-get clean

# Install pandoc
RUN git clone https://github.com/jgm/pandoc.git /source/pandoc && \
    cd /source/pandoc && \
    git checkout tags/1.17.2 -b v1.17.2 && \
    git submodule update --init && \
    stack setup && \
    stack --local-bin-path /usr/local/bin install && \
    cd / && rm -r /source/pandoc

# Install octopress
RUN git clone git://github.com/imathis/octopress.git /octopress && \
    cd /octopress && \
    gem install bundler && \
    bundle install

# Expose default port for octopress preview
EXPOSE 4000
WORKDIR /octopress