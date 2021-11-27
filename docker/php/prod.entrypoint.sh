#!/bin/bash

# setting up laravel
php /work/ice_climber/artisan migrate --force
# php /work/ice_climber/artisan db:seed

# 権限変更
chmod -R 777 /work/ice_climber/bootstrap/cache
chmod -R 777 /work/ice_climber/storage

# 今後エラーになるようならdockerコンテナ作成時にnode_moduleを一旦削除する
# remove node_modules
# rm -rf ${ENV_DOCUMENT_ROOT}/${ENV_SRC_DIRECTORY_NAME}/node_modules

/usr/sbin/php-fpm -F