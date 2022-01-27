#1. Node image for building frontend assets
FROM node:alpine AS builder

WORKDIR /app

#copy all files from current directory to working dir in image 
COPY . .

RUN npm install && npm run build

#2. Nginx stage to serve frontend assets

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*

COPY --from=builder /app/public .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]