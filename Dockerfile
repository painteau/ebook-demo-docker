FROM node:lts AS dependencies
RUN apt update && apt install git
RUN git clone https://github.com/j2qk3b/ebook-demo /ebook-demo
WORKDIR /app
COPY /ebook-demo/package.json /app/
COPY /ebook-demo/package-lock.json /app/
RUN npm clean-install --frozen-lockfile

FROM dependencies AS build
WORKDIR /app
COPY /ebook-demo/. /app/
COPY --from=dependencies /app/node_modules /app/node_modules
RUN npm run build

FROM nginx:stable AS release
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80