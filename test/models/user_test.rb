require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_knows_sold_items
    u = User.create! email: "user@example.com", password: "password"
    assert_equal 0, u.sold_items.count

    u.sold_items << Item.first
    assert_equal 1, u.sold_items.count
  end

  def test_can_reverse_email
    u = User.new email: "james@theironyard.com"
    assert_equal u.name, "James"
  end
end
