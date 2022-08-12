#
# Shipment information for an order
#
class Shipment < ApplicationRecord
  belongs_to :region, class_name: "ShippingRegion", foreign_key: "region_id"
  belongs_to :order
end
