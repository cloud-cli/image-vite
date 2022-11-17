FROM node:14-alpine

RUN sed -i -e 's/^root::/root:!:/' /etc/shadow
RUN set -xe && apk add --no-cache bash git openssh nano python3
RUN adduser -S cloudy -G node
ENV HOME=/home/node
ADD node /home/node
RUN chown -R cloudy:node /home/node

USER cloudy
RUN npm i -g superstatic
WORKDIR /home/app
ENTRYPOINT ["/bin/bash", "/home/node/entrypoint.sh"]

ENV PATH "$PATH:/home/node/npm/bin"
