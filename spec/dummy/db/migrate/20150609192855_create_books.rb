class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :in_stock
      t.belongs_to :category, index: true
      t.belongs_to :author, index: true
      t.string :image
      t.timestamps null: false
    end
  end
end
