# frozen_string_literal: true

# == Schema Information
#
# Table name: stripe_payments
#
#  id                     :uuid             not null, primary key
#  amount                 :integer          not null
#  currency               :string           not null
#  response               :json
#  stripe_customer_id     :string           not null
#  stripe_subscription_id :string
#  stripe_invoice_id      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class StripePayment < ApplicationRecord
  def error_message
    response.dig("last_payment_error", "message")
  end
end
