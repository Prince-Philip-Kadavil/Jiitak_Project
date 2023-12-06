FROM alpine:latest

RUN mkdir /var/nodeapp

WORKDIR /var/nodeapp

COPY . .

RUN apk update 

RUN apk add nodejs npm

RUN npm install

EXPOSE 5000

CMD ["node", "app.js"]
