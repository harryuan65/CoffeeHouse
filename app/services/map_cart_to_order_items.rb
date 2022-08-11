# frozen_string_literal: true

#
# Map cart items from current_cart to new order items
#
class MapCartToOrderItems < ApplicationService
  def initialize(current_cart)
    @cart_items = CartItem.includes(:product).where(cart: current_cart)
  end

  def call
    output = @cart_items.map do |cart_item|
      amount = cart_item.amount
      product = cart_item.product
      OrderItem.new(
        product: product,
        amount: amount,
        total_price: product.price * amount
      )
    end
    complete(output, :ok)
  end
end
