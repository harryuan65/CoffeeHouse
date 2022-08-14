# frozen_string_literal: true

#
# Update cart item amount
#
class UpdateCartItemAmount < ApplicationService
  delegate :errors, to: :@cart_item

  def initialize(params)
    cart_item_id, new_amount = params.values_at(:id, :amount)
    @cart_item = CartItem.includes(:product).find(cart_item_id)
    @new_amount = new_amount.to_i
    @max_amount = @cart_item.product.available_count
  end

  # Cart item will validate amount on its own
  def call
    @cart_item.amount = @new_amount

    if @new_amount > @max_amount
      errors.add(:amount, I18n.t("errors.messages.less_than_or_equal_to", count: max_amount))
    end

    if @cart_item.save
      complete(@cart_item, :ok)
    else
      complete(nil, :bad_request, errors.full_messages * "\n")
    end
  end
end
