# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.string :sku, null: false, index: {unique: true}
      t.string :image_url
      t.string :category, null: false, default: "consumable"
      t.float :price, null: false
      t.string :stripe_price_id, index: {unique: true}
      t.integer :available_count, null: false, default: 0

      t.timestamps
    end
  end
end
