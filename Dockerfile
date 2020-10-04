FROM node:current-alpine

RUN sed -i -e 's/^root::/root:!:/' /etc/shadow
RUN set -xe && apk add --no-cache bash git openssh nano python
RUN adduser -S cloudy -G node
RUN chown -R cloudy:node /home/node
RUN mkdir /home/node/app && chown cloudy:node /home/node/app
ADD conf/.npmrc /home/node
ADD entrypoint.sh /home/node/
ADD monitor.js /home/node/
RUN npm i -g superstatic

ENV HOME=/home/node
WORKDIR /home/node/app
USER cloudy
ENV PATH "$PATH:/home/node/npm/bin"
ENV RESTART_INTERVAL=5000

ENTRYPOINT ["/bin/bash", "/home/node/entrypoint.sh", "run"]

