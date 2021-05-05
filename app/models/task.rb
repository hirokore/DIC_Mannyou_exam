class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :details, presence: true, length: {maximum: 1000}
  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3}
end
