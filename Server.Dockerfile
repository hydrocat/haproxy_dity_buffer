FROM alpine:edge as BUILD

RUN apk add --no-cache python3

ARG RESPONSE
ARG PORT

RUN echo $RESPONSE > /content.txt
RUN echo "#!/bin/sh -e" > /server.sh
RUN echo >> /server.sh
RUN echo echo listening to $PORT >> /server.sh
RUN echo python3 -m http.server $PORT >> /server.sh

RUN chmod +x /server.sh

ENTRYPOINT [ "/server.sh" ]
