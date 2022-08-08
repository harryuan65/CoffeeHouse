#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :check_session

  def create
    cart = AddToCart.call(current_user, params)
    flash[:notice] = "成功新增商品到購物車"
    redirect_to cart_path(cart)
  end
end
