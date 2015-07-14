require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_invoice_knows_number_of_items
    3.times { create :item }
    item_ids = Item.limit(3).pluck(:id)
    invoice = Cart.create_invoice(item_ids)
    assert invoice.persisted?
    assert_equal 3, invoice.total_quantity
  end

end
