# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :status, null: false, default: "pending"
      t.timestamps
    end
  end
end
