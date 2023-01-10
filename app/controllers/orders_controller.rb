#
# Handle order CRUD
#
class OrdersController < ApplicationController
  before_action :authenticate_user!
  delegate :current_cart, to: :current_user

  def new
    result = MapCartToOrderItems.call(current_cart)
    @order_items = result.output
    respond_using(result)
  end

  def index
    @orders = current_user.orders.all
    @orders = Array.new(20, @orders.first)
  end
end
