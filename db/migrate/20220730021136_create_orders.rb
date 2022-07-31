# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :payment, polymorphic: true, null: false, type: :uuid
      t.string :category
      t.integer :stripe_customer_id
      t.string :status

      t.timestamps
    end
  end
end
