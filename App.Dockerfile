FROM alpine:edge as BUILD
RUN apk add --no-cache curl

ARG SLEEP
ARG HOST
ARG PORT
ARG URI
ARG PROXY

# Assembles a recurring http script
RUN echo "#!/bin/sh" > requester.sh
RUN echo "" >> requester.sh
RUN echo "while true; \
    do echo REQUESTING $HOST:$PORT/$URI THOUGH PROXY $PROXY; \
    curl --silent -v -x $PROXY:$PORT $HOST:$PORT/$URI > /response.txt; \
    cat /response.txt; \
    sleep $SLEEP; \
    done" >> /requester.sh

RUN chmod +x /requester.sh

ENTRYPOINT [ "/requester.sh" ]
