# frozen_string_literal: true

# == Schema Information
#
# Table name: cart_items
#
#  id         :uuid             not null, primary key
#  cart_id    :uuid             not null
#  product_id :uuid             not null
#  discount   :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
#
# Link product and cart, containing discount
#
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
end
