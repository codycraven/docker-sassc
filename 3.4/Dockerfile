FROM alpine:3.5
ARG LIBSASS_VERSION
ARG SASSC_VERSION

# Compile and install SassC, without dependency bulk
RUN apk add --no-cache --virtual build-dependencies \
		build-base \
		ca-certificates \
		openssl \
		unzip \
	&& update-ca-certificates \
	&& mkdir -p /usr/local /data \
	&& cd /usr/local \
	&& wget -O libsass.zip "https://github.com/sass/libsass/archive/${LIBSASS_VERSION}.zip" \
	&& wget -O sassc.zip "https://github.com/sass/sassc/archive/${SASSC_VERSION}.zip" \
	&& unzip libsass.zip \
	&& unzip sassc.zip \
	&& export SASS_LIBSASS_PATH=/usr/local/libsass-${LIBSASS_VERSION} \
	&& cd "/usr/local/sassc-${SASSC_VERSION}" \
	&& make \
	&& mv bin/sassc /usr/local/bin/sassc \
	&& rm -fr /usr/local/libsass* /usr/local/sassc* \
	&& apk del build-dependencies

# Run SassC by default
ENTRYPOINT ["sassc"]
VOLUME /data
WORKDIR /data
