class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :details, presence: true, length: {maximum: 1000}
end
