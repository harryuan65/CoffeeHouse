class StripeController < ApplicationController
  before_action :check_session, only: [:checkout]
  # before_action :check_session

  def checkout
    # CheckExistingStripeUser.call(current_user.id)

    # begin
    #   stripe_session = Stripe::Checkout::Session.create(
    #     success_url: "#{payment_success_stripe_index_url}?session_id={CHECKOUT_SESSION_ID}",
    #     cancel_url: root_url,
    #     payment_method_types: ["card"],
    #     mode: "subscription",
    #     line_items: [{
    #       # For metered billing, do not pass quantity
    #       quantity: 1,
    #       price: price_id
    #     }],
    #     customer: current_user.stripe_customer_id,
    #     client_reference_id: current_user.id
    #   )
    # rescue => e
    #   return render json: {error: {message: e}}
    # end

    puts params
  end

  # def checkout
  #   data = JSON.parse(event_payload)
  #   current_user = User.find(data["userId"])
  #   price_id = data["priceId"]
  #   CheckExistingStripeUser.call(current_user.id)

  #   # See https://stripe.com/docs/api/checkout/sessions/create
  #   # for additional parameters to pass.
  #   # {CHECKOUT_SESSION_ID} is a string literal; do not change it!
  #   # the actual Session ID is returned in the query parameter when your customer
  #   # is redirected to the success page.
  #   begin
  #     stripe_session = Stripe::Checkout::Session.create(
  #       success_url: "#{payment_success_stripe_index_url}?session_id={CHECKOUT_SESSION_ID}",
  #       cancel_url: root_url,
  #       payment_method_types: ["card"],
  #       mode: "subscription",
  #       line_items: [{
  #         # For metered billing, do not pass quantity
  #         quantity: 1,
  #         price: price_id
  #       }],
  #       customer: current_user.stripe_customer_id,
  #       client_reference_id: current_user.id
  #     )
  #   rescue => e
  #     return render json: {error: {message: e}}
  #   end

  #   return render json: {sessionId: stripe_session.id}
  # end
end
