# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                 :uuid             not null, primary key
#  user_id            :uuid             not null
#  product_id         :uuid             not null
#  payment_type       :string           not null
#  payment_id         :uuid             not null
#  category           :string
#  stripe_customer_id :integer
#  status             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "rails_helper"

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
