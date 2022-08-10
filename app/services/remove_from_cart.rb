# frozen_string_literal: true

#
# Remove item from cart
#
class RemoveFromCart < ApplicationService
  # @param [Cart] current_cart
  # @param [ActionController::Parameters] params
  def initialize(current_cart, params)
    @items = current_cart.items
    @target_item = @items.find(params[:id])
  end

  def call
    @target_item.destroy
    complete(@items.count, :ok, "成功移除商品")
  end
end
