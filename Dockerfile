FROM xiangsx/chrome:116.0.5845.96

USER root

WORKDIR /usr/src/build

COPY package.json /usr/src/build/
ENV NODE_ENV=dev
RUN npm i --registry=https://registry.npm.taobao.org

COPY . /usr/src/build
RUN npm run build && \
    find ./dist -name "*.js" -exec npx terser {} -o {} \; && \
    mkdir -p /usr/src/app && \
    cp -r ./dist/* /usr/src/app/ && \
    cp -r ./node_modules /usr/src/app/ && \
    rm -rf /usr/src/build

WORKDIR /usr/src/app

VOLUME [ "/usr/src/app/run" ]

EXPOSE 3000

CMD ["node", "index.js"]
