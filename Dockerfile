FROM ghcr.io/cloud-cli/node:latest

USER root
RUN mkdir -p /home/node/npm/lib
COPY workspace /home/workspace
RUN cd /home/workspace && npm i --no-audit
COPY vite-entrypoint.sh /home/node/vite-entrypoint.sh
RUN chmod +x /home/node/vite-entrypoint.sh
ENTRYPOINT ["/bin/bash", "/home/node/vite-entrypoint.sh"]

ENV PATH "$PATH:/home/node/npm/bin:/home/app/node_modules/.bin:/home/workspace/node_modules/.bin"
ENV PORT=3000
