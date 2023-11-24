# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| name               | string | null: false |
| encrypted_password | string | null: false |
| profile            | text   | null: false |
| occupation         | text   | null: false |
| position           | text   | null: false |

has_many :prototypes
has_many :prototypes, through: :comments


## prototypes テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| title              | string    | null: false |
| catch_copy         | text      | null: false |
| concept            | text      | null: false |
| user               | references| null: false |

belongs_to :users
has_many :users, through: :users

## comments テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| content            | text      | null: false |
| prototype          | references| null: false |
| user               | references| null: false |

belongs_to :users
belongs_to :prototypes