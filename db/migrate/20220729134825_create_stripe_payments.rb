# frozen_string_literal: true

class CreateStripePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_payments, id: :uuid do |t|
      t.integer :amount
      t.string :currency
      t.json :response
      t.string :stripe_subscription_id
      t.string :stripe_invoice_id

      t.timestamps
    end
  end
end
