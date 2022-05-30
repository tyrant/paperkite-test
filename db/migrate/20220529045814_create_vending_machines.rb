class CreateVendingMachines < ActiveRecord::Migration[7.0]
  def change
    create_table :vending_machines do |t|
      t.integer :outlet_number
      t.string :plate_number
      t.text :vendor_address
      t.integer :promo_expiry_seconds
      t.boolean :is_happy_hour

      t.timestamps
    end
  end
end
