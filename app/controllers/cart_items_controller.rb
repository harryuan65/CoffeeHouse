#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  before_action :check_session
  delegate :current_cart, to: :current_user

  def create
    result = AddToCart.call(current_cart, params)
    session[:cart_count] = result.output

    respond_using(result)
  end

  def destroy
    result = RemoveFromCart.call(current_cart, params)
    session[:cart_count] = result.output

    respond_using(result)
  end
end
