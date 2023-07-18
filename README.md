# Open beatoraja IR

つくるの２回目

## TODOs

### system

[x] セッション管理

一応DBで管理する実装は追加、そのうちredisとかにする

### APIs

#### ユーザ作成

login時に未登録ユーザだったら勝手に登録するようにした

#### コース管理

#### ライバル管理

### Frontend

全部

このプロジェクト上においてUIframeworkはvuetify3かtailwind予定

## テスト実施方法

1. DockerでMySQLコンテナを立てる

`$ docker-compose up -d`

2. `.env`に接続情報を記載する

デフォルトだと以下  
`DATABASE_URL=mysql://prisma:password@localhost:3306/prisma`

3. テスト実施

`$ npm run test`

-------

以下Nuxt3のテンプレ

# Nuxt 3 Minimal Starter

Look at the [Nuxt 3 documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

## Setup

Make sure to install the dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm run dev

# yarn
yarn dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm run build

# yarn
yarn build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm run preview

# yarn
yarn preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.
