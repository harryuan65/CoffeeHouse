#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  before_action :check_session
  delegate :current_cart, to: :current_user

  def create
    result = AddToCart.call(current_cart, params)
    session[:cart_count] = result.output

    respond_with(result)
  end

  def destroy
    result = RemoveFromCart.call(current_cart, params)
    session[:cart_count] = result.output

    respond_with(result)
  end

  private

  #
  # Response with flash status based on result
  # @param [ApplicationService::Result] result
  #
  def respond_with(result)
    result.for_response do |status, flash_key, message|
      flash.now[flash_key] = message
      render status: status
    end
  end
end
