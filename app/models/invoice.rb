class Invoice < ActiveRecord::Base
  belongs_to :purchaser

  has_many :invoice_items
  has_many :items, through: :invoice_items
end
