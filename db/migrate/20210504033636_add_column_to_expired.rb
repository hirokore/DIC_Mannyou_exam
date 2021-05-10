class AddColumnToExpired < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :expired_at, :date, default: -> { "now()" } , null: false
  end
  def down
    remove_column :tasks, :expired_at
  end
end
