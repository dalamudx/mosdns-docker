FROM --platform=${TARGETPLATFORM} golang:alpine as builder
ARG CGO_ENABLED=0
ARG TAG
ARG REPOSITORY

WORKDIR /root
RUN apk add --update git \
	&& git clone https://github.com/${REPOSITORY} mosdns \
	&& cd ./mosdns \
	&& git fetch --all --tags \
	&& git checkout tags/${TAG} \
	&& go build -ldflags "-s -w -X main.version=${TAG}" -trimpath -o mosdns

FROM --platform=${TARGETPLATFORM} alpine:latest
LABEL maintainer="dalamudx <github.com/dalamudx>"
ARG TARGETPLATFORM
COPY --from=builder /root/mosdns/mosdns /usr/bin/
RUN apk add --no-cache ca-certificates bash tzdata curl supervisor git 
RUN set -x \
	&& platform=`echo ${TARGETPLATFORM}|sed 's/\//-/g'`; \
	downlink='https://github.com/dalamudx/v2dat/releases/latest/download'; \
	if [ ${platform} = 'linux-arm-v6' ] || [ ${platform} = 'linux-arm-v7' ]; \
	then curl -sSL ${downlink}/v2dat-linux-arm -o /usr/bin/v2dat; \
	else curl -sSL ${downlink}/v2dat-${platform} -o /usr/bin/v2dat; \
	fi 
RUN mkdir /app && chmod +x /usr/bin/v2dat /usr/bin/mosdns

VOLUME /app
EXPOSE 53/udp 53/tcp
COPY entrypoint.sh /entrypoint.sh
WORKDIR /app
ENTRYPOINT /entrypoint.sh