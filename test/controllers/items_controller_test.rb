require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def test_new_requires_sign_in
    get :new
    # /users/sign_in
    assert_equal "302", response.code
    assert_includes response.redirect_url, new_user_session_path
  end

  def test_can_see_new_form
    sign_in User.first
    get :new
    assert_equal "200", response.code
    # Really want: has a form that when clicked creates an item
    assert_includes response.body, "<form"
    assert_includes response.body, items_path
  end

  def test_can_create_items
    u = User.first
    sign_in u

    post :create, item: { name: "Thing", price: 10 }

    item = Item.last
    assert_equal "Thing", item.name

    assert_equal "302", response.code
    assert_includes response.redirect_url, item_path(item)
  end
end
