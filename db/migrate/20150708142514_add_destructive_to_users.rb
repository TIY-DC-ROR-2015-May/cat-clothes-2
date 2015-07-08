class AddDestructiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :destructive, :boolean, null: false, default: false
  end
end
