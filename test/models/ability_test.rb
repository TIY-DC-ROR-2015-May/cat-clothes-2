require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  def test_new_users_cant_create
    new_user = User.new created_at: 1.hour.ago
    ability  = Ability.new new_user

    refute ability.can?(:create, Item.new)
  end

  def test_old_users_can_create
    old_user = User.new created_at: 1.week.ago
    ability  = Ability.new old_user

    assert ability.can?(:create, Item.new)
  end

  def test_update_access
    item = Item.first

    sellers_abilities = Ability.new item.seller
    assert sellers_abilities.can? :update, item

    ability = Ability.new User.new
    refute ability.can? :update, item
  end
end