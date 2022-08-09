#
# CartItem CRUD
#
class CartItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :check_session

  def create
    AddToCart.call(current_user, params)
    flash.now.notice = "成功新增商品到購物車"
  end
end
