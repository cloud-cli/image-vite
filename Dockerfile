FROM ghcr.io/cloud-cli/node:latest

USER root
ADD workspace /home/workspace
COPY entrypoint.sh /home/node/vite-entrypoint.sh
RUN cd /home/workspace && npm i && ln -s /home/app /home/workspace/src && chmod +x /home/node/vite-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/home/node/vite-entrypoint.sh"]
RUN chmod -R node:node /home/workspace /home/app
USER node

ENV PATH "$PATH:/home/node/npm/bin:/home/app/node_modules/.bin:/home/workspace/node_modules/.bin"
