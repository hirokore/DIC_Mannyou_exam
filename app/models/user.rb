class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  has_secure_password
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  before_destroy :check_admin_destroy
  before_update :check_admin_update

  private

  def check_admin_update
    if changes.present? 
      if changes[:admin][0]
        throw :abort if User.where(admin: true).count == 1 && self.admin == false
      end
    end
  end
  def check_admin_destroy
    throw :abort if User.where(admin: true).count == 1 && self.admin? == true
  end
end
