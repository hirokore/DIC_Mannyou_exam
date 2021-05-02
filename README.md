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
| dead_line | date |
| priority | integer |

<br>

### Labelモデル

| カラム名 | データ型 | 
| :--- | :--- | 
| id | index | 
| task_id | index | 
| name | string |
