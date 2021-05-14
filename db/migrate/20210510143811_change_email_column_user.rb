class ChangeEmailColumnUser < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :users, :email, :string, unique: true
    end
    def down
      change_column :users, :email, :string
    end
  end
end
