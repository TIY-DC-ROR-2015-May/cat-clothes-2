class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :item, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
