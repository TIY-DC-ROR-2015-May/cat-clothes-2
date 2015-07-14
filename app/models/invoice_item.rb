class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity
end
