#
# Handle order CRUD
#
class OrdersController < ApplicationController
  before_action :authenticate_user!
  delegate :current_cart, to: :current_user

  def index
    @orders = current_user.orders.all
    # @orders = Array.new(20, @orders.first)
  end

  # In order not to show the parameters in query,
  #   use another POST action for new order
  def confirm
    result = CartToNewOrder.call(current_cart)
    @order = result.output
    @region = ShippingRegion.find_by!(code: "TW") # default_region
    @shipping_methods = @region.shipping_methods
    respond_using(result)
  end

  def create
    payment_method = order_params[:payment_method]
    return redirect_to(current_carts_path, alert: "Invalid payment method") unless Order::PAYMENT_METHODS.include?(payment_method)

    order = CreateOrder.call(current_user, order_params).output
    url = GetPaymentRedirectUrl.call(order, payment_method)
    redirect_to(url)
  end

  def show
    @order = current_user.orders.includes(items: [:product]).find(params[:id])
  end

  private

  def order_params
    params.permit(:payment_method, :shipping_method_id, :shipment_city, products: [:id, :amount])
  end
end
