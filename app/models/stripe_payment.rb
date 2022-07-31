#
# Stores stripe payment info
#
class StripePayment < ApplicationRecord
  belongs_to :order, as: :payment
end
