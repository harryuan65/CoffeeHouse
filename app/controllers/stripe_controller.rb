class StripeController < ApplicationController
  before_action :check_session, only: [:checkout]

  def checkout
    CheckExistingStripeUser.call(current_user.id)
    # @type [Array<LineItem>] line_items
    line_items = Stripe::CartToLineItems.call(params).output

    stripe_session = Stripe::CreateOneTimeCheckout.call(
      user: current_user,
      line_items: line_items,
      success_url: stripe_payment_success_url,
      cancel_url: stripe_payment_cancel_url
    ).output

    redirect_to stripe_session.url, allow_other_host: true
  end
end
