ARG BASE_CONTAINER=node:latest

FROM $BASE_CONTAINER AS final-hour-dev

ARG USER=node

LABEL org.opencontainers.image.authors="mikey@blindcomputing.org"

USER $USER
EXPOSE 13000/udp
VOLUME /home/node/app/maps
WORKDIR /home/node
ENTRYPOINT ["npm", "run"]
CMD ["dev"]

RUN --mount=type=bind,source=package.json,target=/home/node/package.json \
    --mount=type=bind,source=package-lock.json,target=/home/node/package-lock.json \
    npm ci

WORKDIR /home/node/app

FROM final-hour-dev AS final-hour-prod

ENV NODE_PATH=./dist
CMD ["start"]

COPY . /home/node/app
RUN npm run build