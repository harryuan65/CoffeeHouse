#
# Record the final state of a purchased product, while referencing the original product
#
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
