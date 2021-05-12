class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_destroy :check_admin
  before_save :check_admin

  private

  def check_admin
    throw :abort if User.where(admin: true).count == 2 && self.admin? == false
  end
end
