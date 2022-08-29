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

  validates :amount, numericality: {greater_than_or_equal_to: 1}

  def to_stripe_line_item
    raise StandardError, "Product not loaded" unless association_cached?(:product)

    Stripe::LineItemVO.new(
      price: product.stripe_price_id,
      quantity: amount
    )
  end
end
