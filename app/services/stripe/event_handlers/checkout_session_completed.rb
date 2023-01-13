# frozen_string_literal: true

module Stripe
  module EventHandlers
    #
    # Handle stripe event: `checkout.session.completed`. Creates an order and stripe payment.
    #
    class CheckoutSessionCompleted < ApplicationService
      # @param [Stripe::Checkout::Session] data_object: a checkout session object
      # @raise [ActiveRecord::RecordNotFound] when user not found
      def initialize(checkout_session)
        @checkout_session = checkout_session
        @order = ::Order.find(order_id)
        @user = User.find_by!(stripe_customer_id: customer)
      end

      def call
        ::Order.transaction { create_payment }
        complete(nil, :ok)
      end

      private

      def create_payment
        stripe_payment = StripePayment.create!(amount: amount, currency: currency, response: @checkout_session)
        @order.update!(payment: stripe_payment, status: :completed)
      end

      def order_id = @checkout_session[:metadata][:order_id]

      # @return [String] "cus_xxx"
      def customer = @checkout_session[:customer]

      # Stripe amount unit is multiplied by 100. The actual amount should be divided by 100
      # @return [Integer]
      def amount = (@checkout_session[:amount_total] / 100)

      # @return [String] "twd"
      def currency = @checkout_session[:currency]
    end
  end
end

__END__

# line_item
# {"id"=>"li_1MLoTUFUSUvjNxGl6Cc2meK2",
#   "object"=>"item",
#   "amount_discount"=>0,
#   "amount_subtotal"=>90000,
#   "amount_tax"=>0,
#   "amount_total"=>90000,
#   "currency"=>"twd",
#   "description"=>"Gold Mandheling - Drip Bag x 20 pcs",
#   "price"=>
#    {"id"=>"price_1LbfXTFUSUvjNxGlUfVfmG2v",
#     "object"=>"price",
#     "active"=>true,
#     "billing_scheme"=>"per_unit",
#     "created"=>1661670251,
#     "currency"=>"twd",
#     "custom_unit_amount"=>nil,
#     "livemode"=>false,
#     "lookup_key"=>nil,
#     "metadata"=>{},
#     "nickname"=>nil,
#     "product"=>"gold_mandheling_drip_20pcs",
#     "recurring"=>nil,
#     "tax_behavior"=>"unspecified",
#     "tiers_mode"=>nil,
#     "transform_quantity"=>nil,
#     "type"=>"one_time",
#     "unit_amount"=>30000,
#     "unit_amount_decimal"=>"30000"},
#   "quantity"=>3}