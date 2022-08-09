# frozen_string_literal: true

class CreateStripePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_payments, id: :uuid do |t|
      t.integer :amount, null: false
      t.string :currency, null: false
      t.json :response
      t.string :stripe_customer_id, null: false
      t.string :stripe_subscription_id
      t.string :stripe_invoice_id

      t.timestamps
    end
  end
end
