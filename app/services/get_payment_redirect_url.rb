# frozen_string_literal: true

#
# Decides the redirect url for payment
#
class GetPaymentRedirectUrl < ApplicationService
  include Rails.application.routes.url_helpers

  # @param [Order] order
  # @param [String] payment_method in Order::PAYMENT_METHODS
  #
  def initialize(order, payment_method)
    @order = order
    @payment_method = payment_method
  end

  def call
    case @payment_method
    when "stripe"
      stripe_checkout_path(order_id: @order.id)
    else
      raise ActiveRecord::RecordNotFound.new(I18n.t("services.get_payment_redirect_url.payment_method_not_supported", method: @payment_method))
    end
  end
end
