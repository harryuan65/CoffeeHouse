# frozen_string_literal: true

#
# Add Product to Cart
#
class AddToCart
  def initialize(current_cart, params)
    @current_cart = current_cart
    @product = Product.find(params[:product_id])
    @amount = params[:amount] || 1
  end

  # @return [Integer] current items count
  def call
    cart_items = @current_cart.items

    if (exisiting_item = cart_items.find_by(product: @product))
      exisiting_item.increment(:amount, @amount) && exisiting_item.save
    else
      cart_items.create(product: @product)
    end

    cart_items.count
  end

  # @param [Cart] current_cart
  # @param [ActionController::Parameters] params
  def self.call(*args)
    ActiveRecord::Base.transaction do
      new(*args).call
    end
  end
end
