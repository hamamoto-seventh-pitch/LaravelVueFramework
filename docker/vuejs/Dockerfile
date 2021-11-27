#nodeイメージをpullする
FROM node:10.15.3-alpine

#working directory
WORKDIR /work/project

#vuecliインストール
RUN npm config set unsafe-perm true
RUN npm install -g @vue/cli
RUN npm install -g webpack-dev-server

### 以下現時点では使用しないためコメントアウト ###

#shファイルをコンテナにコピー
# COPY ./scripts/docker.entrypoint.sh /scripts/entrypoint.sh

#shフォルダの権限追加（全員実行可）
# RUN chmod +x /scripts/*

#初期実行
# ENTRYPOINT [ "/scripts/entrypoint.sh" ]