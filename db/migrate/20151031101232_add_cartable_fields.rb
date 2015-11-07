class AddCartableFields < ActiveRecord::Migration
  def up
    add_column :shopping_cart_order_items, :cartable_id, :integer
    add_column :shopping_cart_order_items, :cartable_type, :string
  end
  def down
    remove_column :shopping_cart_order_items, :cartable_id
    remove_column :shopping_cart_order_items, :cartable_type
  end
end
