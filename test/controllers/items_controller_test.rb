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

  def test_users_can_delete_their_items
    u = login
    item = u.sold_items.create! name: "A", price: 1

    delete :destroy, id: item.id

    # assert_raises(ActiveRecord::NotFound) do
    #   Item.find item.id
    # end
    assert_equal nil, Item.find_by_id(item.id)

    assert_includes flash[:notice], "deleted"
    assert_equal "302", response.code
    assert_includes response.redirect_url, items_path
  end

  def test_users_cannot_delete_other_items
    u = login
    i = Item.create! name: "Arg", price: 1,
      seller: User.where.not(id: u.id).first!

    refute_equal i.seller, u

    assert_raises ActiveRecord::RecordNotFound do
      delete :destroy, id: i.id
    end

    assert Item.find(i.id)
    refute_equal "500", response.code
  end

  def test_must_be_signed_in_to_delete
    delete :destroy, id: Item.first.id
    assert_equal "302", response.code
    assert_includes response.redirect_url, new_user_session_path
  end
end
