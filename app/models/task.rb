class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  accepts_nested_attributes_for :labels, reject_if: :all_blank, allow_destroy: true

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :details, presence: true, length: {maximum: 1000}
  enum status: {"---":0, 未着手:1, 着手中:2, 完了:3}
  enum priority: {"---":0, 低:1, 中:2, 高:3}, _prefix: true

  include Searchable
  def_name_status_like :name, :status
  def_status_search :status
  def_columns_like :name
end
