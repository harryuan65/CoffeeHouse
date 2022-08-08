#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :check_session

  def create
    cart = AddToCart.call(params)
    redirect_to cart_path(cart)
  rescue => exception
    Rails.logger.fatal exception
    flash.now[:alert] = exception and render status: 500
  end
end
