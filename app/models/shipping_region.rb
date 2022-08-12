#
# Available shipping regions
#
class ShippingRegion < ApplicationRecord
  has_many :providers, class_name: "ShippingProvider", foreign_key: "region_id"
  has_many :shipping_methods, through: :providers
end
