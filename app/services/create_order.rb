# frozen_string_literal: true

#
# Create an order on confirm
#
class CreateOrder < ApplicationService
  # @param [User] user: current user
  # @param [Hash] order_params
  # @option order_params [String] shipping_method_id
  # @option order_params [String] shipment_city
  # @option order_params [Array<Hash<String, String>] products: shape [{"id", "amount"}]
  def initialize(user, order_params)
    @user = user
    @order_params = order_params
    validate
  end

  def call
    output = Order.transaction { create_order }
    complete(output, :ok)
  end

  private

  # :reek:FeatureEnvy
  def validate
    validate_arg(@order_params) do |val|
      val.validate :products, is_a: Array, of: ActionController::Parameters, required: true
      val.validate :shipment_city, is_a: String, required: true
      val.validate :shipping_method_id, is_a: String, required: true
    end
  end

  # @return [Array<ActionController::Parameters<String, String>>] shape [{"id", "amount"}]
  def product_infos = @infos ||= @order_params[:products]

  def shipment_city = @order_params[:shipment_city]

  def shipping_method_id = @order_params[:shipping_method_id]

  # Load products once to make sure they all exists and
  #   index them by id.
  # @raise [ActiveRecord::RecordNotFound]
  # @return [Hash<String, Product>] shape {"uuid" => Product, ... }
  def products_index_mapping
    @products ||= begin
      ids = product_infos.map { |info| info[:id] }
      Product.find(ids).index_by(&:id)
    end
  end

  # Initialize items for an order from given product_infos hashes.
  def initialize_items(order)
    product_infos.each do |info|
      id, amount_str = info.values_at(:id, :amount)
      amount = amount_str.to_i
      product = products_index_mapping[id]
      raise ActiveRecord::RecordInvalid.new("Product not enough") if amount > product.available_count
      order.items.build(product: product, amount: amount, total_price: product.price * amount)
    end
  end

  # Will be wrapped inside the transaction
  # @return [Shipment]
  def create_shipment
    shipping_method = ShippingMethod.find(shipping_method_id)

    Shipment.create(shipping_method: shipping_method, city: shipment_city)
  end

  # @return [Order]
  def create_order
    order = @user.orders.new(id: SecureRandom.uuid)
    initialize_items(order)
    order.shipment = create_shipment
    order.save!
    order
  end
end
