#
# Handles cart actions
#
class CartController < ApplicationController
  def show
    @cart = Cart.includes(:items).find(params[:id])
  end
end
