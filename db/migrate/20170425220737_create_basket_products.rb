class CreateBasketProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :basket_products do |t|
      t.references :basket, index: true
      t.references :product, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
