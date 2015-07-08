require 'test_helper'

class EditingAnItemTest < ActionDispatch::IntegrationTest
  def setup
    # Sign in
    @u = User.create!(
      email: "user@example.com",
      password: "password",
      created_at: 2.days.ago
    )
    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    click_link "New Item"
  end

  def test_happy_path
    within "#new_item" do
      fill_in "Name", with: "Concrete Granite Cat Things"
      fill_in "Price", with: 9001
      click_button "Save"
    end

    # Should this be here?
    assert_equal 9001, @u.sold_items.last.price

    assert_includes find('h1').text, "Concrete Granite Cat Things"
    assert_includes find('h2').text, "9001.0"
  end

  def test_validation_redisplay
    within "#new_item" do
      fill_in "Name", with: "Concrete Granite Cat Things"
      click_button "Save"
    end

    # assert page.has_css? "help-block"
    assert_includes find(".help-block").text, "can't be blank"
    refute page.has_css? "h1"
    assert page.has_css? ".has-error #item_price"
  end
end
