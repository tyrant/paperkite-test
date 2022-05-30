class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :type

      t.references :product
      
      t.references :promotion
      t.references :product_1
      t.references :product_2 

      t.timestamps
    end
  end
end
