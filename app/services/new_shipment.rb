# frozen_string_literal: true

#
# Initialize new shipment with default region (TW)
#
class NewShipment < ApplicationService
  def call
    shipment = Shipment.new
    default_region = ShippingRegion.find_by!(code: "TW")
    shipment.region = default_region
    complete(shipment, :ok)
  end
end
