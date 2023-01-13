# frozen_string_literal: true

module Stripe
  #
  # Create one time card payment checkout
  #
  class CreateOneTimeCheckout < ApplicationService
    attr_reader :options

    # @param [Hash] options
    # @option options [User] :user
    # @option options [Stripe::LineItemVO] :line_items
    # @option options [String] :success_url
    # @option options [String] :cancel_url
    #
    def initialize(options)
      @options = options
      validate
    end

    # :reek:FeatureEnvy
    # :reek:TooManyStatements
    def validate
      validate_arg(options) do |opt|
        opt.validate :user, is_a: User, required: true
        opt.validate :line_items, is_a: Array, of: Stripe::LineItemVO, required: true
        opt.validate :success_url, is_a: String, required: true
        opt.validate :cancel_url, is_a: String, required: true
        opt.validate :metadata, is_a: Hash, required: true
      end
    end

    def call
      stripe_session = Stripe::Checkout::Session.create(
        line_items: line_items.map(&:to_h),
        success_url: success_url,
        cancel_url: cancel_url,
        payment_method_types: ["card"],
        mode: "payment",
        customer: user.stripe_customer_id,
        client_reference_id: user.id,
        metadata: metadata
      )
      complete(stripe_session, :ok)
    end

    private

    def user = options[:user]

    def line_items = options[:line_items]

    def success_url = options[:success_url]

    def cancel_url = options[:cancel_url]

    def metadata = options[:metadata]
  end
end
