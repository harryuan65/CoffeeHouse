# frozen_string_literal: true

#
# Keeps track of users cart items, will be references by an order after purchase
#
class Cart < ApplicationRecord
  belongs_to :user
end
