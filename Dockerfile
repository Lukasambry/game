ARG NODE_IMAGE=node:22.11.0

#Base
FROM $NODE_IMAGE AS base
RUN mkdir -p /home/node/app && chown node:node /home/node/app
WORKDIR /home/node/app
USER node
RUN mkdir tmp

#Dependencies
FROM base AS dependencies
COPY --chown=node:node ./package*.json ./
RUN npm i
COPY --chown=node:node . .

#Build
FROM dependencies AS build
RUN node ace build --production

#Production
FROM base AS production
ENV NODE_ENV=production
ENV PORT=$PORT
ENV HOST=0.0.0.0
COPY --chown=node:node ./package*.json ./
RUN npm ci --production
COPY --chown=node:node --from=build /home/node/app/build .
EXPOSE $PORT
CMD [ "node", "server.js" ]
