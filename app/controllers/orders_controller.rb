#
# Handle order CRUD
#
class OrdersController < ApplicationController
  delegate :current_cart, to: :current_user

  def new
    result = MapCartToOrderItems.call(current_cart)
    @order_items = result.output
    respond_with(result)
  end
end
