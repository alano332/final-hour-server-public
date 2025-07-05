from node:alpine

ADD . /app
WORKDIR /app
RUN npm install
RUN npx tsc
EXPOSE 13000
ENTRYPOINT ["node", "--enable-source-maps", "dist/server.js"]
