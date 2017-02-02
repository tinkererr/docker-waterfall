FROM java:8-alpine

ARG WATERFALL_BUILD=88
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=58288239480c80d56f81e3788a78cd1a1ef5d8d14aea584fd6536f542bf9e95d6ed53e8021a23e0b22009a6e6760b292ea12f89fd7ddc3630258a0c5ba7b24b8

WORKDIR /data
ADD "${WATERFALL_URL}" /srv/waterfall.jar
RUN cd /srv &&\
	chmod 444 /srv/waterfall.jar

ADD start.sh /usr/local/bin/waterfall
RUN chmod +x /usr/local/bin/waterfall

ENV JAVA_ARGS "-Xmx1G"
ENV WATERFALL_ARGS ""

VOLUME "/data"

CMD ["waterfall"]
