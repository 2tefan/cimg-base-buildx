# cimg-base-buildx
Did you ever want to use the new [buildx features](https://github.com/docker/buildx) in CircleCI, but didn't find a good base image?
This is the solution to your problem, you can just download this repository and create a new base image as often as you desire.

If you don't want to build it yourself, there is also a version of this on [DockerHub](https://hub.docker.com/r/2tefan/cimg-base-buildx). The tag is always like this: `${CIMG_VERSION}-${BUILDX_VERSION}`. This means that e.g. `2tefan/cimg-base-buildx:stable-18.04-0.4.1` is using cimg version `stable-18.04` and it is using buildx version `0.4.1`.

## Building
To build a new image, you can just use the `build.sh` script. This will build with the default cimg & buildx version (currently stable-18.04 & 0.4.1), but you can specify them with the following arguments:

### Arguments
To set the cimg version:
* --cimg= 
* --cimg-version=
* --cv=
* --CIMG_VERSION=

To set the buildx version:
* --buildx= 
* --buildx-version=
* --bv=
* --BUILDX_VERSION=

If you want the script to automatically upload the image to dockerhub, you can specify the docker repository and if you want it to be pushed:

To set the docker repository:
* --dockerrepo= 
* --docker-repository=
* --dr=
* --DOCKER_REPOSITORY=

If you want to push it:

* --push
* -p

### Example

To build it with cimg version `stable-18.04`, buildx version `0.4.1` and push it to `2tefan/cimg-base-buildx:stable-18.04-0.4.1` the following command would be needed:

`./build.sh -p --cimg=stable-18.04 --buildx=0.4.1 --dockerrepo=2tefan/cimg-base-buildx:stable-18.04-0.4.1`

But because the default values could also be used, it can be shorten to:

`./build.sh -p`
