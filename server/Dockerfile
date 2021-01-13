FROM node:14

WORKDIR /app

COPY app.js .
COPY package.json .

RUN npm i

EXPOSE 3000

CMD node app.js
