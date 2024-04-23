FROM node:alpine
RUN git clone https://github.com/j2qk3b/ebook-demo
WORKDIR /ebook-demo
RUN npm install && npm cache clean --force
COPY . /app
EXPOSE 5173
CMD ["npm", "start"]