#!/bin/sh

docker run --rm -ti \
    -v $HOME/gdrive:/Users/cbreuel/Google\ Drive/ \
    devenv bash
