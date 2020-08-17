#!/bin/sh

_CIMG_VERSION=stable-18.04
_BUILDX_VERSION=0.4.1
_DOCKER_REPOSITORY="2tefan/cimg-base-buildx"

PUSH=NO

if [ -z "${CIMG_VERSION}" ]; then
   CIMG_VERSION="${_CIMG_VERSION}"
fi
if [ -z "${_BUILDX_VERSION}" ]; then
   BUILDX_VERSION="${_BUILDX_VERSION}"
fi
if [ -z "${DOCKER_REPOSITORY}" ]; then
   DOCKER_REPOSITORY="${_DOCKER_REPOSITORY}"
fi

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
