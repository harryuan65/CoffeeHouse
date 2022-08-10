#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  before_action :check_session
  delegate :current_cart, to: :current_user

  def create
    addition = AddToCart.call(current_cart, params)
    session[:cart_count] = addition.result
    flash.now.notice = "成功新增商品到購物車"
  end

  def destroy
    items = current_cart.items
    items.find(params[:id]).destroy
    @items_count = items.count
    session[:cart_count] = @items_count
    flash.now.notice = "成功移除商品"
  end
end
