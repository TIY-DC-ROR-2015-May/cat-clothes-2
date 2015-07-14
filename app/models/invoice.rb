class Invoice < ActiveRecord::Base
  belongs_to :purchaser

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def total_quantity
    invoice_items.sum('quantity')
  end

  def amount_in_cents
    (self.total_cost * 100).to_i
  end

end
