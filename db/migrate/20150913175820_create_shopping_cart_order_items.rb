class CreateShoppingCartOrderItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_order_items do |t|
      t.float :price
      t.integer :quantity
      t.belongs_to :product
      t.belongs_to :order
      t.timestamps null: false
    end
  end
end
