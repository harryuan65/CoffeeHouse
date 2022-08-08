#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :check_session

  def create
    cart = AddToCart.call(current_user, params)
    redirect_to cart_path(cart)
  end
end
