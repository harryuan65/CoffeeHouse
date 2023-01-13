# frozen_string_literal: true

module Stripe
  #
  # Handles stripe webhook event
  #
  class EventDispatcher < ApplicationService
    #
    # Initialize a stripe event from params
    #
    # @param [String] payload
    # @param [String] sig_header
    #
    def initialize(payload, sig_header)
      @payload = payload
      @sig_header = sig_header
      @event = construct_event
    end

    def call
      dispatch_event
    end

    private

    # @return [Stripe::StripeObject] one of stripe's object types. We can access its fields using symbols
    # e.g. https://stripe.com/docs/api/checkout/sessions
    def data_object = @event[:data][:object]

    def endpoint_secret
      @endpoint_secret ||= Rails.application.credentials.dig(:stripe, :endpoint_secret)
    end

    # @return [Stripe::Event]
    # @raise [Exception(JSON::ParserError, Stripe::SignatureVerificationError)]
    def construct_event
      Stripe::Webhook.construct_event(
        @payload, @sig_header, endpoint_secret
      )
    end

    # Find a handler to parse the event.
    # - [Migrate from to charges events to payment_intent](https://stripe.com/docs/payments/payment-intents/migration/charges)
    # - [Which stripe event to listen for](https://stackoverflow.com/questions/72165704/stripe-checkout-webhook-which-event-to-listen-for)
    # @return [#call]
    def find_handler
      event_type = @event.type
      case event_type
        # when "invoice.paid" # subscription
        # when "invoice.payment_failed" # ?subscription payment failed?
      when "payment_intent.payment_failed" # failed card payment
        EventHandlers::PaymentIntentFailed
      when "checkout.session.completed" # successful card payment
        EventHandlers::CheckoutSessionCompleted
      else # default handler
        ->(obj) { complete(nil, :bad_request, "Unhandled event type: #{event_type}") }
      end
    end

    # @return [ApplicationService::Result]
    def dispatch_event
      save_for_debug if Rails.env.development?
      find_handler.call(data_object)
    end

    def save_for_debug
      filename = "#{@event.type}.json"
      dir = "spec/fixtures/files/stripe/#{Time.now.strftime("%Y%m%d%H-%M-%S")}"
      if !::File.directory?(dir)
        require "fileutils"
        ::FileUtils.mkdir_p(dir)
      end
      ::File.write(Rails.root.join(dir, filename), JSON.pretty_generate(data_object))
    end
  end
end
