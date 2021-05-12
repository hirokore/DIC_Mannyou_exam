class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

end
