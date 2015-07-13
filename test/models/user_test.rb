require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_user_knows_sold_items
    u = create :user
    assert_equal 0, u.sold_items.count

    u.sold_items << Item.first
    assert_equal 1, u.sold_items.count
  end

  def test_can_reverse_email
    u = create :user, email: "james@theironyard.com"
    assert_equal u.name, "James"
  end
end
