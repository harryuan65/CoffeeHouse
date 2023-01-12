# frozen_string_literal: true

module Stripe
  #
  # Map current order items to stripe line items for checkout
  #
  class OrderToLineItems < ApplicationService
    def initialize(order)
      @order_items = order.items.includes(:product).select(:id, :product_id, :amount)
    end

    def call
      complete(@order_items.map(&:to_stripe_line_item), :ok)
    end
  end
end
