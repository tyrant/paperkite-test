class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :description
      t.decimal :cost
      t.decimal :discount
      t.string :image_url
      t.string :promotion_type
      t.boolean :is_happy_hour

      t.timestamps
    end
  end
end
