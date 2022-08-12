#
# Handles cart actions
#
class CartsController < ApplicationController
  before_action :check_session
  delegate :current_cart, to: :current_user

  def current
    @cart = current_cart
    @items = @cart.items.includes(:product)
    # @type [Shipment] shipment
    shipment = NewShipment.call.output
    @region = shipment.region
    @shipping_methods = @region.shipping_methods
  end

  def check_out
    @cart = current_cart
    CartItem.update(cart_items_params.keys, cart_items_params.values)
    redirect_to new_order_path(cart_id: @cart.id)
  end

  def cart_items_params
    params.require(:cart_items)
  end
end
