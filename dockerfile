FROM node:20.4.0-bookworm-slim as node
FROM ubuntu:jammy-20230624 as base
COPY --from=node /usr/local/include/ /usr/local/include/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /usr/local/bin/ /usr/local/bin/
RUN corepack disable && corepack enable
RUN groupadd --gid 1000 node &&\
    useradd --uid 1000 --gid node --shell /bin/bash --create-home node && \
    mkdir /src
WORKDIR /src
RUN npm install -g npm@9.8.0

FROM base as dev
ENV NODE_ENV=development
ENV PATH=$PATH:/src/node_modules/.bin
COPY ./src/package*.json ./
RUN npm install
CMD [ "npm", "run", "dev" ]