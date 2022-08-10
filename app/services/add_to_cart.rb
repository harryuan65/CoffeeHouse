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

    if (exisiting_item = cart_items.find_by(product: @product))
      increase_amount_for(exisiting_item)
    else
      cart_items.create(product: @product)
    end

    @result = cart_items.count

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
  def increase_amount_for(exisiting_item)
    current_amount = exisiting_item.amount
    new_total_amount = current_amount + @amount

    if new_total_amount <= @product.available_count
      exisiting_item.increment(:amount, @amount) && exisiting_item.save
    end
  end
end
