FROM java:8-alpine

ARG WATERFALL_BUILD=91
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=ba4ec3d44bda97997dfe79ca56d786580d23e137cb0349c56c9f6d7c9770cc77d8176865cca56bb2f8ccfaf4cef0931d09f4b9f5fcc3d23c4b131eb5c660a794

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
