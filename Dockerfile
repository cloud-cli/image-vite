FROM ghcr.io/cloud-cli/node:latest

USER root
COPY workspace /home/workspace
COPY vite-entrypoint.sh /home/node/vite-entrypoint.sh
RUN cd /home/workspace && npm i && chmod +x /home/node/vite-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/home/node/vite-entrypoint.sh"]

ENV PATH "$PATH:/home/node/npm/bin:/home/app/node_modules/.bin:/home/workspace/node_modules/.bin"
ENV PORT=3000