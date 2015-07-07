require 'test_helper'

class EditingAnItemTest < ActionDispatch::IntegrationTest
  def test_happy_path
    # Sign in
    u = User.create! email: "user@example.com", password: "password"
    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    click_link "New item"

    within "#new_item" do
      fill_in "Name", with: "Concrete Granite Cat Things"
      fill_in "Price", with: 9001
      click_button "Save"
    end

    # assert_equal 9001, Item.last.price ?

    assert_includes find('h1').text, "Concrete Granite Cat Things"
    assert_includes find('h2').text, "9001.0"
  end
end
