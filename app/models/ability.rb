class Ability
  include CanCan::Ability

  def initialize(user=nil)
    user ||= User.new(created_at: Time.now)

    can :read, Item

    if user.created_at < 1.day.ago
      can :create, Item
    end
    can [:update, :destroy], Item, seller_id: user.id

    # if user.superuser?
    #   can :manage, :all
    # end
    if user.destructive?
      can :destroy, :all
    end
  end
end
