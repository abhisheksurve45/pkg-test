FROM --platform=linux/amd64 node:16-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

EXPOSE 9000

RUN apk update && apk add --no-cache curl make gcc g++ binutils-gold linux-headers paxctl libgcc libstdc++ git tar gzip python3 py3-pip

RUN npm install pkg -g

RUN pkg src/index.js -c package.json --targets node16-alpine-x64 -o pkg-test

FROM --platform=linux/amd64 alpine

RUN apk add --no-cache libstdc++ libgcc

COPY --from=build /usr/src/app/pkg-test pkg-test

RUN apk update && apk add dumb-init
ENTRYPOINT ["dumb-init", "--"]

EXPOSE 3000
CMD ["./pkg-test"]
