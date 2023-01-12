# frozen_string_literal: true

#
# Add Product to Cart
#
class AddToCart < ApplicationService
  attr_reader :message

  # @param [Cart] current_cart
  # @param [ActionController::Parameters] params
  def initialize(current_cart, params)
    @items = current_cart.items
    @product = Product.find(params[:product_id])
    @amount = params[:amount] || 1
  end

  def call
    current_count = @items.count

    if @items.exists?(product: @product)
      complete(current_count, :ok, I18n.t("services.add_to_cart.already_in_cart"))
    else
      @items.create(product: @product)
      complete(current_count + 1, :ok, I18n.t("services.add_to_cart.success"))
    end
  end
end
