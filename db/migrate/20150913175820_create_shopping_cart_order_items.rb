class CreateShoppingCartOrderItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_order_items do |t|
      t.float :price
      t.integer :quantity
      t.belongs_to :order
      t.references :cartable, polymorphic: true
      t.timestamps null: false
    end
    add_index :shopping_cart_order_items, :cartable_id
  end
end
