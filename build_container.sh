#!/bin/bash

# Pick a version from https://www.python.org/ftp/python/
PYTHON_MAJOR=3
PYTHON_MINOR=8
PYTHON_MICRO=2

# Pick a tag from https://hub.docker.com/_/ubuntu?tab=description
UBUNTU_VERSION=18.09

PYTHON_VERSION=$PYTHON_MAJOR.$PYTHON_MINOR.$PYTHON_MICRO
VERSION=$PYTHON_VERSION\_$UBUNTU_VERSION

echo Building CPython $PYTHON_VERSION based on Ubuntu $VERSION

sed -i "s/FROM ubuntu:18.04/FROM ubuntu:$UBUNTU_VERSION/g" Dockerfile

docker build . -t richarddally/cpython:$PYTHON_MAJOR.$PYTHON_MINOR.$PYTHON_MICRO --build-arg PYTHON_MAJOR=$PYTHON_MAJOR --build-arg PYTHON_MINOR=$PYTHON_MINOR --build-arg PYTHON_MICRO=$PYTHON_MICRO"
