class CreateShoppingCartOrders < ActiveRecord::Migration
  def change
    create_table :shopping_cart_orders do |t|
      t.float :total_price, default: 0
      t.date :completed_date
      t.string :state, default: "in_progress"
      t.belongs_to :credit_card
      t.belongs_to :user
      t.belongs_to :delivery
      t.timestamps null: false
    end
  end
end
