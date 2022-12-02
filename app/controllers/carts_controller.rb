#
# Handles cart actions
#
class CartsController < ApplicationController
  before_action :check_session
  delegate :current_cart, to: :current_user

  def current
    @cart = current_cart
    @items = @cart.items.includes(:product)
    default_region = ShippingRegion.find_by!(code: "TW")
    @region = default_region
    @shipping_methods = @region.shipping_methods
  end

  # Turbo stream needs a redirect
  def check_out
    redirect_to new_order_path
  end

  # TODO: V2 check_out_carts_path
  # Turbo stream needs a redirect
  # def check_out
  #   redirect_to new_order_path
  # end

  def cart_items_params
    params.require(:cart_items)
  end
end
