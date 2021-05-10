class AddColumnTasksPriority < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :priority, :integer, default: 0 , null: false
  end
  def down
    remove_column :tasks, :priority
  end
end
