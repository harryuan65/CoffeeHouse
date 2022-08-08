# == Schema Information
#
# Table name: order_items
#
#  id         :uuid             not null, primary key
#  product_id :uuid             not null
#  order_id   :uuid             not null
#  price      :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
#
# Record the final state of a purchased product, while referencing the original product
#
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
