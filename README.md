# base-laravel-vuejs

## Introduction

本リポジトリは、Dockerをベースとした、Laravel + vueの開発環境を構築します。

ご自身のプロジェクトを利用する場合は、"project/"配下を置き換えてください。

## 構築環境

Laravel

Vue.js

## 想定ディレクトリ構成

```
project/
├── README.md
├── docker/
│   ├── vuejs/
│   ├── php/
│   ├── mariadb/
│   ├── nginx/
│   ├── .env.example
│   └── docker-compose.yml
└── project
    ├── frontend/
    └── backend/
```

## 事前準備

環境変数を.envファイルにまとめて、そちらを参照する形式となります。

ご自身の環境に応じて変更してください。

```shell
# .envファイル作成
$ cd docker
$ cp .env.example .env
```

## 構築手順

### コンテナ起動

```shell
$ docker-compose up -d
```

### コンテナ起動確認

Dockerコンテナが正常に起動しているか確認します。

```shell
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS                                       NAMES
904b04de7df0   web       "/usr/sbin/nginx -g …"   6 seconds ago    Up 6 seconds   0.0.0.0:8000->80/tcp, :::8000->80/tcp       web
8b430b6bbfd1   api       "docker-php-entrypoi…"   9 seconds ago    Up 6 seconds   9000/tcp                                    api
7d0eb78f303c   front     "node"                   10 seconds ago   Up 7 seconds   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   front
fb05ed0656a6   db        "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp   db

```

※もしこの時点で、`STATUS`の値がRestarting...等の場合、構築に失敗しています。編集箇所を確認してみてください。

### 各コンテナ初期設定

#### apiコンテナ初期設定

```shell
$ docker exec -it api bash
$ composer install
$ php artisan key:generate
$ php artisan config:clear
$ php artisan migrate
$ php artisan db:seed
```

#### frontコンテナ初期設定

```shell
$ docker exec -it front ash
$ npm install
$ npm run dev
```

### 動作確認

#### ブラウザ

http://localhost:8080/ にアクセスしてVue.jsのTOPページが出てきたら成功

#### API疎通確認

```shell
# ローカル環境から以下コマンドを叩きJSONが返却されたら成功
$ curl -kv -X GET http://127.0.0.1:8000/api/v1/Test
> {"controller":"TestController","method":"index"}
```
