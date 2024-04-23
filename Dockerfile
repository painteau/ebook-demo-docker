FROM node:alpine
RUN apk update && \
    apk add --update git && \
    apk add --update openssh
WORKDIR /
RUN git clone https://github.com/j2qk3b/ebook-demo
WORKDIR /ebook-demo
RUN npm install
EXPOSE 5173

CMD ["npm run dev"]