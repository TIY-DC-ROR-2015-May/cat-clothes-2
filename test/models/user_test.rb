require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def create_user! overrides={}
    User.create!(
      email:    overrides[:email]    || "user@example.com",
      password: overrides[:password] || "password"
    )
  end

  def test_user_knows_sold_items
    u = create_user!
    assert_equal 0, u.sold_items.count

    u.sold_items << Item.first
    assert_equal 1, u.sold_items.count
  end

  def test_can_reverse_email
    u = create_user! email: "james@theironyard.com"
    assert_equal u.name, "James"
  end
end
