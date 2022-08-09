# frozen_string_literal: true

#
# Add Product to Cart
#
class AddToCart < ApplicationService
  def initialize(current_cart, params)
    @current_cart = current_cart
    @product = Product.find(params[:product_id])
    @amount = params[:amount] || 1
  end

  def call
    cart_items = @current_cart.items

    @result = if (exisiting_item = cart_items.find_by(product: @product))
      increment_cart_item_amount(exisiting_item)
    else
      cart_items.create(product: @product)
      cart_items.count
    end

    self
  end

  # @param [Cart] current_cart
  # @param [ActionController::Parameters] params
  def self.call(*args)
    ActiveRecord::Base.transaction do
      new(*args).call
    end
  end

  private

  # Checks if this item can be added x @amount again,
  # capped by product's available count
  # @param [Integer] final amount of the item
  def increment_cart_item_amount(exisiting_item)
    current_amount = exisiting_item.amount
    new_total_amount = current_amount + @amount

    if new_total_amount <= @product.available_count
      exisiting_item.increment(:amount, @amount) && exisiting_item.save
      new_total_amount
    else
      current_amount
    end
  end
end
