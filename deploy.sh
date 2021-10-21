#!/usr/bin/env sh

# 当发生错误时中止脚本
set -e

# 构建
npm run build

# cd 到构建输出的目录下 
cd dist

git init
git add -A
git commit -m 'deploy'

# 部署到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:billxu0521/back4blood.git master:gh-pages
Username: billxu0521
Password: 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

cd -