FROM java:8-alpine

ARG WATERFALL_BUILD=82
ARG WATERFALL_URL=https://ci.destroystokyo.com/job/Waterfall/${WATERFALL_BUILD}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar
ARG WATERFALL_SHA512=0b448be45b8e0ad204a9212b173ac0fd9b4c216f6745a5ff3425378d40b9e9e44be9abf98f9b8b89e9b7992b62158bd0cd0684ca98fc83f792c40eaae5984b4a

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
