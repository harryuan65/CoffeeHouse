# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items, id: :uuid do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.monetize :discount, null: false, default: 0, currency: {present: true}
      t.timestamps
    end
  end
end
