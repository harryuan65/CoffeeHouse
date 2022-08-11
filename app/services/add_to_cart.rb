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
      complete(current_count, :ok, "商品已存在購物車")
    else
      @items.create(product: @product)
      complete(current_count + 1, :ok, "成功新增商品至購物車")
    end
  end
end
