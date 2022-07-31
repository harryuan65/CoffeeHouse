class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.string :image_url
      t.monetize :price, null: false, currency: {present: true}

      t.timestamps
    end
  end
end
