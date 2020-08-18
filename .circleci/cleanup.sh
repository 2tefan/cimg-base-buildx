#!/bin/sh

. $(dirname $0)/common.sh

curl -i -X DELETE \
                 -H "Accept: application/json" \
                 -H "Authorization: JWT ${HUB_TOKEN}" \
                 https://hub.docker.com/v2/repositories/${DOCKER_USERNAME}/${DOCKER_REPOSITORY}/tags/${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG}/