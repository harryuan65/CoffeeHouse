module Stripe
  #
  # Stripe line item value object
  #
  class LineItemVO
    attr_reader :price, :quantity

    def initialize(price:, quantity:)
      @price = price
      @quantity = quantity
    end

    def to_h
      {
        price: price,
        quantity: quantity
      }
    end

    alias_method :as_json, :to_h
  end
end
