class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, Item
    can :update, Item, seller_id: user.id
  end
end
