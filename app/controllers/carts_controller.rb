#
# Handles cart actions
#
class CartsController < ApplicationController
  before_action :check_session

  def current
    @cart = current_user.current_cart
    @items = @cart.items.includes(:product)
  end
end
