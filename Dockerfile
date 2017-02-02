FROM java:8-alpine

ARG WATERFALL_BUILD=85
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=31460683ff251820b38d0a702187523dd6ec22beb246c128849ecc51bc6f6bb9e1d88fbc240cd282f11545e7a815c30a8fcb11242136206e70283d937a0fc310

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
