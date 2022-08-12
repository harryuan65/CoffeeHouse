class CreateShippingRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_regions, id: :uuid do |t|
      t.string :code, index: true
      t.string :name, null: false
      t.string :dial_code, null: false

      t.timestamps
    end
  end
end
