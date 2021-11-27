#!/bin/sh

#node_modulesインストール
echo "npm install"
npm install 

#vue起動
echo "npm run dev"
npm run dev

#メモを出力
echo "localhost:8080"