FROM java:8-alpine

ARG WATERFALL_BUILD=93
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=75624371cf65ee68214ce364673fcb4c5c87bedf1ebfd819b951000a3882fe80386a613f082f3f3e2e8c95c6c9a4933dfa9d4f6aa2b33f089ed196efc187f633

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
