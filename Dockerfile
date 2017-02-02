FROM java:8-alpine

ARG WATERFALL_BUILD=87
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=602f74a74e7660b7037b0431a00505ba2c2e78fbafbaa2cdaf850791806a32f8eb531c2c10b24689d7ffdd0654f6ad6c1310ea1a69fde4befbc3d78ffefd9d4e

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
