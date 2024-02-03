# CPython Docker image

Build CPython 3 from scratch to provide a ready-to-use Docker image (based on Ubuntu image).

## GitHub automatic build

Read [build.yaml](.github/workflows/build.yaml)

## Docker Hub

[DockerHub](https://hub.docker.com/r/richarddally/cpython) stores all Docker images built by GitHub infra.

### Build a custom version

Modify this shell code example to build your own CPython image.

```shell script
#!/bin/bash

# Pick a tag from https://hub.docker.com/_/ubuntu?tab=description
UBUNTU_VERSION=23.10

# Pick a version from https://www.python.org/ftp/python/
PYTHON_VERSION=3.13.0

echo "Building CPython ${PYTHON_VERSION} based on Ubuntu ${UBUNTU_VERSION}"
docker build . -t richarddally/cpython:${PYTHON_VERSION} --build-arg BASE_IMAGE=${UBUNTU_VERSION} --build-arg PYTHON_VERSION=${PYTHON_VERSION}
```
