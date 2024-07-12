# Project RQB バックエンド環境構築

1. clone する
1. `.env`をバックのプロジェクトのルートに作成
1. `docker compose build`
1. `docker compose run --rm web rails db:create`
1. `docker compose up`

## .env の内容

必要な環境変数が増えたら下記に追加していってください

```
FRONT_URL=http://localhost:8000
```

## 認証機能の追加方法
### 以下の項目を.envファイルに追加する必要があります。（一つ一つ解説）

- GITHUB_KEY=　「githubのClient ID　例(Ov23****************)」
- GITHUB_SECRET=　「githubのClient secrets　例(**********f118)」
- JWT_SECRET_KEY=　「生成したシークレットキー」

### GITHUB_KEYとGITHUB_SECRETについて
GITHUB_KEYとGITHUB_SECRETはrbqのsettingの中から確認できます。

- GITHUB＿KEYは共有の(Ov23****************)
- GITHUB_SECRETは「Generate a new client secret」にて作成

上記二つは最後のproject-rqbのリンクで画面遷移を行うことで確認ができるので設定を行ってください
※今回は安全性の確保のためproject-rqbへの画面遷移は行っていません

[![Image from Gyazo](https://i.gyazo.com/ee2543c7635d94b0e473dfc122e05194.gif)](https://gyazo.com/ee2543c7635d94b0e473dfc122e05194)

### JWT_SECRET_KEYについて
JWT_SECRET_KEYはシークレットキーを生成して設定する必要があるので以下のコマンドをターミナル上で行い、キーの作成を行ってください

```
node -e "console.log(require('crypto').randomBytes(256).toString('base64'));"
```
