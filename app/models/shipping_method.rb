#
# Information for a shipping method
#
class ShippingMethod < ApplicationRecord
  belongs_to :provider, class_name: "ShippingProvider", foreign_key: "provider_id"
end
