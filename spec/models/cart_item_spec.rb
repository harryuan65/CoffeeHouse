# frozen_string_literal: true

# == Schema Information
#
# Table name: cart_items
#
#  id         :uuid             not null, primary key
#  cart_id    :uuid             not null
#  product_id :uuid             not null
#  amount     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe CartItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
