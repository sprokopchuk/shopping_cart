require 'aasm'
module ShoppingCart
  class Order < ActiveRecord::Base
    include AASM
    scope :in_progress, -> {where state: ['in_progress', "address", "delivery", "payment", "confirm"]}
    belongs_to :user, class_name: ShoppingCart.user_class.to_s
    belongs_to :credit_card
    has_many :order_items
    belongs_to :delivery
    has_one :billing_address, class_name: "ShoppingCart::Address", through: :user
    has_one :shipping_address, class_name: "ShoppingCart::Address", through: :user
    validates :total_price, :state, presence: true
    validates :total_price, numericality: true

    aasm :whiny_transitions => false, :column => 'state' do
      state :in_progress, :initial => true
      state :address
      state :delivery
      state :payment
      state :confirm
      state :in_queue
      state :in_delivery
      state :delivered
      state :canceled

      event :next_step_checkout do
        transitions :from => :in_progress, :to => :address
        transitions :from => :address, :to => :delivery
        transitions :from => :delivery, :to => :payment
        transitions :from => :payment, :to => :confirm
        transitions :from => :confirm, :to => :in_queue, :after => [:set_total_price, :set_completed_date]
      end

      event :confirm do
        transitions :from => :in_queue, :to => :in_delivery, :after => :set_completed_date
      end

      event :cancel do
        transitions :from => [:in_queue, :in_delivery], :to => :canceled
      end
      event :finish do
        transitions :from => :in_delivery, :to => :delivered, :after => :set_completed_date
      end

    end

    def set_total_price
      price_with_delivery
      self.save
    end

    def set_completed_date
      self.completed_date = DateTime.now
      self.save
    end
    def number
      "R" << self.id.to_s.rjust(9, '0')
    end

    def add order_item
      item = OrderItem.find_by(product_id: order_item.product_id, order_id: self.id)
      if item.nil?
        self.order_items << order_item
      else
        amount_ordered = item.quantity
        amount_ordered += order_item.quantity
        item.update_attributes(quantity: amount_ordered)
      end
    end

    def number
      "R" << self.id.to_s.rjust(9, '0')
    end
    def real_price
      self.total_price = 0
      self.order_items.find_each do |item|
        self.total_price += item.price * item.quantity
      end
      self.total_price
    end
    def ready_to_checkout?
      self.real_price > 0
    end
    def price_with_delivery
      self.delivery.nil? ? real_price : self.total_price = real_price + delivery.price
    end

    def merge other_order
      current_order_items = self.order_items
      other_order.order_items.each do |order_item|
        if current_order_items.include? order_item
          current_order_item = OrderItem.find_by(product_id: order_item.product_id, order_id: self.id)
          amount_ordered = current_order_item.quantity
          amount_ordered += order_item.quantity
          current_order_item.update_attributes(quantity: amount_ordered)
       else
          order_item.order_id = self.id
          order_item.save
        end
      end
    end

  end
end
