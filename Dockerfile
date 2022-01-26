# Extending image
FROM node:alpine

RUN apt-get update

RUN apt-get update \
    && apt-get install autoconf libtool nasm libpng-dev automake pkg-config build-essential wget \
    -yq --no-install-suggests --no-install-recommends --force-yes

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Versions
RUN npm -v
RUN node -v

# Install app dependencies
COPY package.json /usr/src/app/
COPY package-lock.json /usr/src/app/

RUN npm install

# Bundle app source
COPY . /usr/src/app

# Port to listener
EXPOSE 3000

# Environment variables
ENV NODE_ENV production
ENV PORT 3000
ENV PUBLIC_PATH "/"

RUN npm run start:build

# Main command
CMD [ "npm", "run","start:server"]