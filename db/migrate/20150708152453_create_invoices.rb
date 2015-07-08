class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :purchaser, index: true, foreign_key: true
      t.decimal :total_cost
      t.datetime :paid_at

      t.timestamps null: false
    end
  end
end
