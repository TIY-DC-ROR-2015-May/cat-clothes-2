module ApplicationHelper
  def cart
    bought_items = session[:cart] || []

    c = Cart.new
    bought_items.each do |id|
      c.add_item(Item.find id)
    end
    c
  end
end
