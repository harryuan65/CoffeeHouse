# frozen_string_literal: true

#
# Link product and cart, containing discount
#
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
end
