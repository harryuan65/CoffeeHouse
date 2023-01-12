# == Schema Information
#
# Table name: order_items
#
#  id          :uuid             not null, primary key
#  product_id  :uuid             not null
#  order_id    :uuid             not null
#  amount      :integer          not null
#  total_price :float            default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def to_stripe_line_item
    raise StandardError, "Product not loaded" unless association_cached?(:product)

    Stripe::LineItemVO.new(
      price: product.stripe_price_id,
      quantity: amount
    )
  end
end
