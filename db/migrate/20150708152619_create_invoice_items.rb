class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.belongs_to :invoice
      t.belongs_to :item
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
