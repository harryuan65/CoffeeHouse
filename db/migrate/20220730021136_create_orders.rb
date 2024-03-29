# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      # USE ORDER ITEMS to refer to products instead
      # t.references :product, null: false, foreign_key: true, type: :uuid

      # Removed null false constraint and allow later payment.
      t.references :payment, polymorphic: true, type: :uuid
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
