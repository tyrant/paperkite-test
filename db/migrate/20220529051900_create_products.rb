class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.decimal :price
      t.boolean :is_available
      t.integer :display_order
      t.string :image_url
      t.string :packaging_group
      t.string :name
      t.integer :volume

      t.references :vending_machine
      t.references :packaging_group

      t.timestamps
    end
  end
end
