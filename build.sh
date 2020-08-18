#!/bin/sh

_CIMG_VERSION="stable-18.04"
_BUILDX_VERSION="0.4.1"
_DOCKER_REPOSITORY="2tefan/cimg-base-buildx"
_APPEND_TAG="$(git rev-parse HEAD)"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

PUSH=NO

if [ -z "${CIMG_VERSION}" ]; then
    CIMG_VERSION="${_CIMG_VERSION}"
fi
if [ -z "${BUILDX_VERSION}" ]; then
    BUILDX_VERSION="${_BUILDX_VERSION}"
fi
if [ -z "${DOCKER_REPOSITORY}" ]; then
    DOCKER_REPOSITORY="${_DOCKER_REPOSITORY}"
fi
if [ -z "${APPEND_TAG}" ]; then
    case "${BRANCH}" in
    develop)
        APPEND_TAG="-dev"
        ;;
    master)
        APPEND_TAG=""
        ;;
    *)
        APPEND_TAG="-${_APPEND_TAG}"
        ;;
    esac
fi

for arg in "$@"; do
    case "${arg}" in
    --push | -p)
        PUSH=YES
        ;;
    --cimg=* | --cimg-version=* | --cv=* | --CIMG_VERSION=*)
        CIMG_VERSION="${arg#*=}"
        ;;
    --buildx=* | --buildx-version=* | --bv=* | --BUILDX_VERSION=*)
        BUILDX_VERSION="${arg#*=}"
        ;;
    --dockerrepo=* | --docker-repository=* | --dr=* | --DOCKER_REPOSITORY=*)
        DOCKER_REPOSITORY="${arg#*=}"
        ;;
    --appendtag=* | --append-tag=* | --at=* | --APPEND_TAG=*)
        APPEND_TAG="${arg#*=}"
        ;;
    esac
done

docker build \
    --build-arg CIMG_VERSION=${CIMG_VERSION} \
    --build-arg BUILDX_VERSION=${BUILDX_VERSION} \
    --tag ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG} .

if [ ${PUSH} = "YES" ]; then
    docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"
    docker push ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG}
fi
