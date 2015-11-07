class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can [:read, :update, :create, :destroy, :state, :all_events], ShoppingCart::Order
      can :complete, ShoppingCart::Order, :user_id => user.id, state: "confirm"
      #can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order_id => user.current_order_in_progress.id
      can :manage, User
    elsif user.guest?
      #can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order_id => user.current_order_in_progress.id
      can :update, ShoppingCart::Order, :user_id => user.id
    else
      can :complete, ShoppingCart::Order, :user_id => user.id, state: "confirm"
      #can [:create, :destroy, :destroy_all], ShoppingCart::OrderItem, :order_id => user.current_order_in_progress.id
      can [:read, :update], ShoppingCart::Order, :user_id => user.id
    end
  end
end
