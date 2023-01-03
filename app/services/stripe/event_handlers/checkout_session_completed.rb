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
        @user = User.find_by!(stripe_customer_id: customer)
        load_products
      end

      def call
        create_order
        complete(nil, :ok)
      end

      private

      def load_products
        line_items
        products_mapping
        nil
      end

      def create_order
        ActiveRecord::Base.transaction do
          stripe_payment = StripePayment.create!(amount: amount, currency: currency, response: @checkout_session)
          order = @user.orders.create!(payment: stripe_payment, status: :completed)
          line_items.each do |line_item|
            order.items.create!(order_item_info(line_item))
          end
        end
      end

      # Utilities

      # @return [String] "cs_xxx"
      def checkout_session_id = @checkout_session[:id]

      # @return [String] "cus_xxx"
      def customer = @checkout_session[:customer]

      # @return [Integer]
      def amount = @checkout_session[:amount_total]

      # @return [String] "twd"
      def currency = @checkout_session[:currency]

      # @return [Array<Hash<String, Object>>] NOTE: String keys
      def line_items
        @line_items ||= begin
          data = Stripe::Checkout::Session.list_line_items(checkout_session_id).data
          data.as_json # allows me to use #values_at
        end
      end

      # For each line item, find the corresponding product
      # @return [Hash<String,Product>]
      def products_mapping
        @products ||= begin
          stripe_product_ids = line_items.map { |item| item.dig("price", "product") }
          ::Product.where(sku: stripe_product_ids).index_by(&:sku)
        end
      end

      # Organize a order item from a line item and its corresponding product
      # @param [Hash<String,Product>] line_item
      def order_item_info(line_item)
        price_info, total_price, quantity = line_item.values_at("price", "amount_total", "quantity")
        sku = price_info["product"] # sku = stripe_product_id
        product = products_mapping[sku]
        {product: product, total_price: total_price, amount: quantity}
      end
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