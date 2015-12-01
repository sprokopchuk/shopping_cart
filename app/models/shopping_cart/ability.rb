module ShoppingCart
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new
      if user.admin?
        can [:read, :update, :create, :destroy, :state, :all_events], ShoppingCart::Order
        can :complete, ShoppingCart::Order, :user_id => user.id, state: "confirm"
        can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order => {user_id: user.id}
        can :manage, ShoppingCart::Delivery
      elsif user.guest?
        can [:create, :destroy, :destroy_all], OrderItem, :order => {user_id: user.id}
        can :update, ShoppingCart::Order, :user_id => user.id
      else
        can :complete, ShoppingCart::Order, :user_id => user.id, state: "confirm"
        can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order => {user_id: user.id}
        can [:read, :update], ShoppingCart::Order, :user_id => user.id
      end
    end
  end
end
