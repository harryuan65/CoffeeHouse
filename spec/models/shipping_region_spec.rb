# == Schema Information
#
# Table name: shipping_regions
#
#  id         :uuid             not null, primary key
#  code       :string
#  name       :string           not null
#  dial_code  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe ShippingRegion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end