#1. Node image for building frontend assets
FROM node:14 AS builder

WORKDIR /app

#copy all files from current directory to working dir in image 
COPY . .

RUN yarn install && yarn build

#2. Nginx stage to serve frontend assets

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
EXPOSE 80
COPY --from=builder /app/public .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]