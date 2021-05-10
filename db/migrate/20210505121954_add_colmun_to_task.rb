class AddColmunToTask < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :status, :integer, default: 0 , null: false
  end
  def down
    remove_column :tasks, :status
  end
end