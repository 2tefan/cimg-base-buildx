ARG CIMG_VERSION

FROM alpine AS fetcher
ARG BUILDX_VERSION

RUN apk add curl

RUN curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"

RUN chmod a+x /docker-buildx

FROM cimg/base:${CIMG_VERSION}

COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx