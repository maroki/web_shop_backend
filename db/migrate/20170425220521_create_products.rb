class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
