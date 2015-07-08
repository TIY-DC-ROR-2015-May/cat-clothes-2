class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Item

    if user.created_at < 1.day.ago
      can :create, Item
    end
    can [:update, :destroy], Item, seller_id: user.id
  end
end
