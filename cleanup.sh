#!/bin/sh -x

. $(dirname $0)/common.sh
echo ${BRANCH}

case "${BRANCH}" in
master)
    echo "Master stays!"
    ;;
*)
    curl -i -X DELETE \
        -H "Accept: application/json" \
        -H "Authorization: JWT ${HUB_TOKEN}" \
        https://hub.docker.com/v2/repositories/${DOCKER_REPOSITORY}/tags/${CIMG_VERSION}-${BUILDX_VERSION}${APPEND_TAG}/
    ;;
esac
