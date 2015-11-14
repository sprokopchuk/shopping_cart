class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user
      can :complete, ShoppingCart::Order, :user_id => user.id, state: "confirm"
      can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order => {user_id: user.id}
      can [:read, :update], ShoppingCart::Order, :user_id => user.id
    end
  end
end
