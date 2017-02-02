FROM java:8-alpine

ARG WATERFALL_BUILD=80
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=78d465c328c5d05a0e451710cffcccb28553212c1c335c613ee88d46581e7a8479e7bf690a7ed349d0441fa97e11c3f0bf8f028327a07a6a9aa43392788f70f4

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
