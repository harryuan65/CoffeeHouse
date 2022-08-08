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
require "rails_helper"

RSpec.describe OrderItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
