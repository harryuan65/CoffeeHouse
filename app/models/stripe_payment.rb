# frozen_string_literal: true

#
# Stores stripe payment info
#
class StripePayment < ApplicationRecord
  belongs_to :order
end
