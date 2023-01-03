# frozen_string_literal: true

module Stripe
  module EventHandlers
    #
    # Handle stripe event: `payment_intent.payment_failed`. Creates a failed order and stripe payment.
    #
    class PaymentIntentPaymentFailed < ApplicationService
      # @param [Stripe::PaymentIntent] payment_intent : access its fields using symbol
      def initialize(payment_intent)
        @payment_intent = payment_intent
        @user = User.from_stripe_customer(customer)
      end

      def call
        message = ActiveRecord::Base.transaction do
          stripe_payment = StripePayment.create!(amount: amount, currency: currency, response: @payment_intent)
          @user.orders.create!(status: :failed, payment: stripe_payment)
          stripe_payment.error_message
        end
        complete(nil, :bad_request, message)
      end

      private

      def amount = @payment_intent[:amount]

      def currency = @payment_intent[:currency]

      def customer = @payment_intent[:customer]
    end
  end
end
