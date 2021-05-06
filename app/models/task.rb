class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :details, presence: true, length: {maximum: 1000}
  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3}

  include Searchable
  def_name_status_like :name, :status
  def_status_search :status
  def_columns_like :name
end
