# frozen_string_literal: true

module Stripe
  #
  # Map current cart items to stripe line items for checkout
  #
  class CartToLineItems < ApplicationService
    def initialize(cart)
      @cart_items = cart.items.includes(:product).select(:id, :product_id, :amount)
    end

    def call
      complete(@cart_items.map(&:to_stripe_line_item), :ok)
    end
  end
end
