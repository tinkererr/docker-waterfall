FROM openjdk:8-jre-alpine

ARG WATERFALL_GIT_URL=https://github.com/WaterfallMC/Waterfall.git
ARG WATERFALL_VERSION=8ff8de0fbdbf14d0b3e842780738f6d0b204d07a

ARG MAVEN_VERSION=3.3.9

ARG WATERFALL_WORKSPACE=/usr/src/waterfall

# Dependencies that need to be permanently installed
RUN apk add --no-cache \
	libc6-compat

# Building
RUN \
	apk add --no-cache --virtual .build-deps \
		bash \
		git \
		openjdk8="${JAVA_ALPINE_VERSION}" \
		&&\
	\
	wget "http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" &&\
	tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz &&\
	rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	mv apache-maven-$MAVEN_VERSION /usr/lib/mvn &&\
	export MAVEN_HOME="/usr/lib/mvn" &&\
	export PATH="${PATH}:${MAVEN_HOME}/bin" &&\
	\
	git config --global user.email "root@docker" &&\
	git config --global user.name "Docker Build" &&\
	git clone --recursive \
		"${WATERFALL_GIT_URL}" "${WATERFALL_WORKSPACE}" &&\
	\
	cd "${WATERFALL_WORKSPACE}" &&\
	git checkout "${WATERFALL_VERSION}" &&\
	./build.sh &&\
	rm -f Waterfall-Proxy/bootstrap/target/original-* &&\
	mkdir -vp /srv &&\
	chmod -v 444 Waterfall-Proxy/bootstrap/target/*.jar &&\
	mv -v Waterfall-Proxy/bootstrap/target/*.jar /srv &&\
	\
	cd /srv &&\
	rm -rf "${WATERFALL_WORKSPACE}" "${MAVEN_HOME}" &&\
	apk del .build-deps

COPY start.sh /usr/local/bin/waterfall
RUN chmod +x /usr/local/bin/waterfall

ENV JAVA_ARGS "-Xmx1G"
ENV WATERFALL_ARGS ""

VOLUME "/data"

CMD ["waterfall"]
