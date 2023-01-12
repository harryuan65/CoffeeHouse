# frozen_string_literal: true

#
# Initialize an order with items from user's current_cart
#
class CartToNewOrder < ApplicationService
  def initialize(current_cart)
    @user = current_cart.user
    # @type [Array(Product, Integer)] @product_with_amount
    @product_with_amount = CartItem.includes(:product).where(cart: current_cart).map do |cart_item|
      [cart_item.product, cart_item.amount]
    end
  end

  def call
    order = @user.orders.new(id: SecureRandom.uuid)
    @product_with_amount.each do |product, amount|
      order.items.build(
        product: product,
        amount: amount,
        total_price: product.price * amount
      )
    end
    complete(order, :ok)
  end
end
