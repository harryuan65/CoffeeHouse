# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.string :image_url
      t.float :price, null: false

      t.timestamps
    end
  end
end
