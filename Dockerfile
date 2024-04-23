FROM node:alpine AS dependencies
RUN apk update && apk add --update git
WORKDIR /app
RUN git clone https://github.com/j2qk3b/ebook-demo 
WORKDIR /app/ebook-demo
RUN npm clean-install --frozen-lockfile

FROM dependencies AS build
WORKDIR /app/ebook-demo
COPY --from=dependencies /app/ebook-demo/node_modules /app/ebook-demo/node_modules
RUN npm run build

FROM nginx:alpine AS release
COPY --from=build /app/ebook-demo/dist /usr/share/nginx/html
EXPOSE 80