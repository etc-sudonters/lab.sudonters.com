#!/bin/sh

if [ $# != 2 ]; then
    echo "expected 2 arguments: src dst"
    exit 2
fi

if [ ! -d "$1" ]; then
    echo "no network config to load"
    exit 0
fi

cp -rv "$1" "$2"
