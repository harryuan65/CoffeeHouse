# frozen_string_literal: true

module Stripe
  #
  # Map current cart items to stripe line items for checkout
  #
  class CartToLineItems < ApplicationService
    def initialize(params)
      @cart_items = CartItem.includes(:product)
        .select(:id, :product_id, :amount)
        .find(params[:cart_items].keys)
    end

    def call
      complete(@cart_items.map(&:to_stripe_line_item), :ok)
    end
  end
end
