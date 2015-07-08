class Cart
  def initialize
    @contents = []
  end

  def add_item item
    @contents.push item
  end

  def item_count
    @contents.count
  end
end