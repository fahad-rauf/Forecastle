FROM node:9.8-alpine

COPY ./src /app

ARG VERSION_URL=https://raw.githubusercontent.com/stakater/stk/add-jenkinsfile-to-stk/.

RUN TOKEN=$(cat /home/jenkins/.apitoken/hub) \
    && VERSION=$(curl -H 'Authorization: token ${TOKEN}' -H 'Accept: application/vnd.github.v4.raw' -L ${VERSION_URL}) \
    && curl -H 'Authorization: token ${TOKEN}' -H 'Accept: application/vnd.github.v4.raw' \
    -L https://github.com/stakater/stk/releases/download/${VERSION}/stk_${VERSION}_linux_386.tar.gz | tar zxv -C ./temp \
    && cp ./temp/stk /usr/local/bin/stk \
    && rm -rf ./temp/*

RUN cd /app && npm install

ENTRYPOINT [ "" ]
CMD ["sh", "-c", "cd /app && node app.js"]
