#
# Companies that provide shipment service
#
class ShippingProvider < ApplicationRecord
  has_many :shipping_methods, foreign_key: "provider_id"
  belongs_to :region, class_name: "ShippingRegion", foreign_key: "region_id"
end
