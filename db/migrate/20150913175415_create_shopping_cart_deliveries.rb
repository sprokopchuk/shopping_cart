class CreateShoppingCartDeliveries < ActiveRecord::Migration
  def change
    create_table :shopping_cart_deliveries do |t|
      t.string :name
      t.float :price
      t.timestamps null: false
    end
  end
end
