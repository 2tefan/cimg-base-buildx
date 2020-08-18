#!/bin/sh

. $(dirname $0)/common.sh/

docker build \
    --build-arg CIMG_VERSION=${CIMG_VERSION} \
    --build-arg BUILDX_VERSION=${BUILDX_VERSION} \
    --tag ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG} .

if [ ${PUSH} = "YES" ]; then
    docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"
    docker push ${DOCKER_REPOSITORY}:${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG}
fi
