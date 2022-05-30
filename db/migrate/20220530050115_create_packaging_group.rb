class CreatePackagingGroup < ActiveRecord::Migration[7.0]
  def change
    create_table :packaging_groups do |t|
      t.string :code

      t.timestamps
    end
  end
end
