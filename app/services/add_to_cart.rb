# frozen_string_literal: true

#
# Add Product to Cart
#
class AddToCart
  # @param [User] user
  # @param [ActionController::Parameters] params
  def initialize(user, params)
    @user = user
    @product = Product.find(params[:product_id])
    @amount = params[:amount] || 1
  end

  # @return [Cart] current cart
  #
  def call
    cart_items = current_cart.items

    if (current_item = cart_items.find_by(product: @product))
      current_item.increment(:amount, @amount) && current_item.save
    else
      cart_items.create(product: @product)
    end

    current_cart
  end

  def self.call(*args)
    ActiveRecord::Base.transaction do
      new(*args).call
    end
  end

  private

  def current_cart
    @current_cart ||= @user.current_cart
  end
end
