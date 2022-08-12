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
#
# Available shipping regions
#
class ShippingRegion < ApplicationRecord
  has_many :providers, class_name: "ShippingProvider", foreign_key: "region_id"
  has_many :shipping_methods, through: :providers
end
