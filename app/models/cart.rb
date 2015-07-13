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
end