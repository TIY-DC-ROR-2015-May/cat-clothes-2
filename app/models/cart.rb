class Cart
  def initialize
    @contents = []
  end

  def add_item item
    @contents.push item
  end

  def count
    @contents.count
  end

  def self.create_invoice(items_ids)
    @invoice = Invoice.create!
    items_ids.each do |item_id|
      item = Item.find(item_id)
      @invoice.invoice_items.create(item_id: item.id, quantity: 1)

      @invoice.total_cost ||= 0
      @invoice.total_cost += item.price.to_i
    end
    return @invoice 
  end
end