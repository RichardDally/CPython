# CPython docker image

Build CPython 3 from scratch to provide a ready-to-use Docker image (based on Ubuntu image).


### Docker Hub

[DockerHub infrastructure](https://hub.docker.com/r/richarddally/cpython) is automatically building branches (combination of CPython and Ubuntu versions).


### Pull Requests

Pull requests are welcomed if you need a new version or propose Docker image improvement.
1. `README.md` is modified only in `master` branch.
2. Create a new branch with following nomenclature PYTHONVERSION_UBUNTUVERSION (e.g. 3.8.2_20.04)
3. Modify Dockerfile to change Ubuntu version and PYTHON major/minor/micro versions.
4. Submit your pull request for approval.

### Build a custom version

Modify this shell code example to build your own CPython image.

```shell script
#!/bin/bash

# Pick a version from https://www.python.org/ftp/python/
PYTHON_MAJOR=3
PYTHON_MINOR=8
PYTHON_MICRO=2

# Pick a tag from https://hub.docker.com/_/ubuntu?tab=description
UBUNTU_VERSION=18.04

PYTHON_VERSION=$PYTHON_MAJOR.$PYTHON_MINOR.$PYTHON_MICRO
VERSION=$PYTHON_VERSION\_$UBUNTU_VERSION

echo Building CPython $PYTHON_VERSION based on Ubuntu $VERSION

sed -i "s/FROM ubuntu:18.04/FROM ubuntu:$UBUNTU_VERSION/g" Dockerfile

docker build . -t richarddally/cpython:$PYTHON_MAJOR.$PYTHON_MINOR.$PYTHON_MICRO --build-arg PYTHON_MAJOR=$PYTHON_MAJOR --build-arg PYTHON_MINOR=$PYTHON_MINOR --build-arg PYTHON_MICRO=$PYTHON_MICRO"
```
