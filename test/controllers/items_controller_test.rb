require 'test_helper'

class ItemsControllerTest < ActionController::TestCase

  def test_new_requires_sign_in
    get :new
    # /users/sign_in
    assert_equal "302", response.code
    assert_includes response.redirect_url, new_user_session_path
  end

  def test_can_see_new_form
    login
    get :new
    assert_equal "200", response.code
    # Really want: has a form that when clicked creates an item
    assert_includes response.body, "<form"
    assert_includes response.body, items_path
  end

  def test_can_create_items
    u = login

    post :create, item: { name: "Thing", price: 10 }

    item = Item.last
    assert_equal "Thing", item.name

    assert_equal "302", response.code
    assert_includes response.redirect_url, item_path(item)
  end

  def test_create_validates_params
    u = login

    existing = Item.count
    post :create, item: { price: 10 }

    assert_equal existing, Item.count

    assert_equal "200", response.code
    assert_includes response.body, "error"
  end
end
