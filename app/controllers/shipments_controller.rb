#
# Shipment CRUD
#
class ShipmentsController < ApplicationController
  def new
    code = shipment_params.dig(:region, :code)
    @region = ShippingRegion.includes(:providers, :shipping_methods).find_by(code: code)
  end

  private

  def shipment_params
    params.fetch(:shipment)
  end
end
