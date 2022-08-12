# == Schema Information
#
# Table name: shipping_methods
#
#  id          :uuid             not null, primary key
#  provider_id :uuid             not null
#  name        :string
#  fee         :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
#
# Information for a shipping method
#
class ShippingMethod < ApplicationRecord
  belongs_to :provider, class_name: "ShippingProvider", foreign_key: "provider_id"
end
