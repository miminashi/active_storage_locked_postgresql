# active_storage_locked_postgresql

https://github.com/miminashi/active_storage_locked のPostgreSQL版

以下の組み合わせではデータベースがロックしないことを確認するためコード

- Rails7
- PostgreSQL
- Active Job with async adapter

動作確認手順

- このレポジトリをclone
- `docker compose build`
- `docker compose run --rm web rails db:create`
- `docker compose run --rm web rails db:reset`
  - db/seeds.rb から10個エントリが作成る
- `docker compose run --rm web rails secret > secret.txt`
- `SECRET_KEY_BASE="$(cat secret.txt)" docker compose up -d`
- `User.destroy_all`
