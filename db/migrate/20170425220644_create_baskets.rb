class CreateBaskets < ActiveRecord::Migration[5.0]
  def change
    create_table :baskets do |t|
      t.decimal :full_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
