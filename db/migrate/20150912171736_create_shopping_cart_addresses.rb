class CreateShoppingCartAddresses < ActiveRecord::Migration
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :address
      t.integer :zipcode
      t.string :city
      t.string :phone
      t.belongs_to :country, index:true
      t.integer :user_id
      t.boolean :billing_address
      t.boolean :shipping_address

      t.timestamps null: false
    end
  end
end
