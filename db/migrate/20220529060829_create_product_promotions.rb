class CreateProductPromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_promotions do |t|
      t.references :product
      t.references :promotion
      t.integer :bundle_number
      t.timestamps
    end
  end
end
