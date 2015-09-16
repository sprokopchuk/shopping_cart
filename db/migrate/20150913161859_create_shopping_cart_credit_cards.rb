class CreateShoppingCartCreditCards < ActiveRecord::Migration
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :number
      t.integer :cvv
      t.integer :exp_month
      t.integer :exp_year
      t.string :first_name
      t.string :last_name
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
