class StripeController < ApplicationController
  before_action :check_session, only: [:checkout]
  skip_forgery_protection only: :webhook # it's ok since stripe doesn't have the csrf token and the signature should match

  def checkout
    order = Order.find(params[:order_id])
    CheckExistingStripeUser.call(current_user.id)
    # @type [Array<LineItem>] line_items
    line_items = Stripe::OrderToLineItems.call(order).output

    stripe_session = Stripe::CreateOneTimeCheckout.call(
      user: current_user,
      line_items: line_items,
      success_url: stripe_payment_success_url,
      cancel_url: stripe_payment_cancel_url
    ).output

    redirect_to stripe_session.url, allow_other_host: true
  end

  def webhook
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    result = Stripe::EventDispatcher.call(payload, sig_header)

    return head result.status
  end
end
