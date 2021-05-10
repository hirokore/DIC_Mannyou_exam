# README

## テーブルスキーマ（モデル名、カラム名、データ型）
<br>

### Userモデル

| カラム名 | データ型 | 
| :--- | :--- | 
| id | index | 
| name | string | 
| email | string |
| password_digest | string |

<br>

### Taskモデル

| カラム名 | データ型 | 
| :--- | :--- | 
| id | index | 
| user_id | index | 
| name | string |
| status | string |
| expired_at | integer |
| priority | integer |

<br>

### Labelモデル

| カラム名 | データ型 | 
| :--- | :--- | 
| id | index | 
| task_id | index | 
| name | string |
<br>


## herokuデプロイ
### 使用GEM
##### ruby '2.6.5'
##### BUNDLED WITH 2.2.16
<br>

#### $ heroku create
##### >reating app... done, ⬢ still-wildwood-55628
<br>

#### $ heroku stack:set heroku-18 
##### >Setting stack to heroku-18... done
<br>

#### $ RAILS_ENV=production bin/rails assets:precompile 
<br>

#### $ git push heroku step2:master
<br>

#### $ heroku run rails db:migrate