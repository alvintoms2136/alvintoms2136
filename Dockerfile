FROM node:22-alpine

RUN npm install -g openclaw@latest

RUN addgroup -g 1001 clawdbot \
  && adduser -D -G clawdbot -u 1001 clawdbot

ENV HOME=/home/clawdbot
WORKDIR /home/clawdbot

COPY --chown=clawdbot:clawdbot start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

USER clawdbot

ENTRYPOINT ["/usr/local/bin/start.sh"]
