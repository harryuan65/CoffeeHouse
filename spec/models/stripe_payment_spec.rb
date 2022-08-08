# frozen_string_literal: true

# == Schema Information
#
# Table name: stripe_payments
#
#  id                     :uuid             not null, primary key
#  amount                 :integer
#  currency               :string
#  response               :json
#  stripe_subscription_id :string
#  stripe_invoice_id      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "rails_helper"

RSpec.describe StripePayment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
