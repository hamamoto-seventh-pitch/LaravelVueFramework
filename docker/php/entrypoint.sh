#!/bin/bash

# Linux環境においてhost側のuser:groupを継承するよう変更
USER_ID=${ENV_LOCAL_UID:-9001}
GROUP_ID=${ENV_LOCAL_GID:-9001}
useradd -u $USER_ID -o -m ${ENV_LOCAL_UNAME}
groupmod -g $GROUP_ID ${ENV_LOCAL_UNAME}
export HOME=/home/${ENV_LOCAL_UNAME}

# 権限変更
chmod -R 777 ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/bootstrap/cache
chmod -R 777 ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/storage

# .envを作成
cp ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env.example ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env

# .env内の環境変数をDockerで定義した環境変数に変更
sed -i -e "s|^DB_CONNECTION=.*$|DB_CONNECTION=${ENV_DB_CONNECTION}|g" ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env
sed -i -e "s|^DB_HOST=.*$|DB_HOST=${ENV_DB_HOST}|g" ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env
sed -i -e "s|^DB_DATABASE=.*$|DB_DATABASE=${ENV_DB_DATABASE}|g" ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env
sed -i -e "s|^DB_USERNAME=.*$|DB_USERNAME=${ENV_DB_USERNAME}|g" ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env
sed -i -e "s|^DB_PASSWORD=.*$|DB_PASSWORD=${ENV_DB_PASSWORD}|g" ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/.env

# コンテナ新規作成時の処理をまとめる
cp /tmp/init.sh ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/init.sh

# 今後エラーになるようならdockerコンテナ作成時にnode_moduleを一旦削除する
# remove node_modules
# rm -rf ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/node_modules

chown -R ${ENV_LOCAL_UNAME}:${ENV_LOCAL_UNAME} ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}

/usr/sbin/php-fpm -F