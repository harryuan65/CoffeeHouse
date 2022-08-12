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
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  after_destroy_commit { broadcast_remove_to "cart_items" }
end
