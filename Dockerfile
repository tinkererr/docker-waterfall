FROM java:8-alpine

ARG WATERFALL_BUILD=84
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=9825201088c640e44781417fe33a020ef63e502ff6e6b0117b56738157c760e9e05ef4e607c7c36094ed987d2f8471d9ad6f1c084e13b8f227a33ac7412b7071

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
