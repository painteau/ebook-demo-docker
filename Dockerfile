FROM node:lts AS dependencies
WORKDIR /app
ADD package.json package-lock.json /app/
RUN npm clean-install --frozen-lockfile

FROM dependencies AS build
WORKDIR /app
ADD . /app/
COPY --from=dependencies /app/node_modules /app/node_modules
RUN npm run build

FROM nginx:stable AS release
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80