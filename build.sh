#!/bin/sh

CIMG_VERSION=stable-18.04
BUILDX_VERSION=0.4.1
PUSH=NO
DOCKER_REPOSITORY="2tefan/cimg-base-buildx"

for arg in "$@"; do
    case "${arg}" in
    --push | -p)
        PUSH=YES
        ;;
    --cimg=* | --cimg-version=* | --cv=* | --CIMG_VERSION=*)
        CIMG_VERSION="${arg#*=}"
        shift
        ;;
    --buildx=* | --buildx-version=* | --bv=* | --BUILDX_VERSION=*)
        BUILDX_VERSION="${arg#*=}"
        shift
        ;;
    --dockerrepo=* | --docker-repository=* | --dr=* | DOCKER_REPOSITORY=*)
        DOCKER_REPOSITORY="${arg#*=}"
        shift
        ;;
    esac
done

docker build \
    --build-arg CIMG_VERSION=${CIMG_VERSION} \
    --build-arg BUILDX_VERSION=${BUILDX_VERSION} \
    --tag ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION} .

if [ ${PUSH} = "YES" ]; then
    docker login
    docker push ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION}
fi
