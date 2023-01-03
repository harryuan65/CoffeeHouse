# frozen_string_literal: true

#
# Custom stripe helpers.
#
module StripeHelpers
  module_function

  # I was looking for a way to create a stripe objects to test more precisely
  # And I found that stripe does `#request_stripe_object` -> `Util#convert_to_stripe_object_with_params(resp.data, {}, {})`
  # where resp.data is equivalent to `JSON.parse("sample_data.json", symbolize_names: true)`
  # @param [String] fixtures_file_stripe_path
  def stripe_object_from(fixtures_file_stripe_path)
    raw = JSON.parse(file_fixture("stripe/#{fixtures_file_stripe_path}").read, symbolize_names: true)
    Stripe::Util.convert_to_stripe_object_with_params(raw, {}, {})
  end

  # Try to simulate that the cart items are all on Stripe as line items.
  def cart_to_stripe_list_object(cart)
    Stripe::Util.convert_to_stripe_object_with_params({
      object: "list",
      data: cart.items.map(&method(:cart_item_to_line_item))
    }, {}, {})
  end

  # @param [CartItem] cart_item
  def cart_item_to_line_item(cart_item)
    product = cart_item.product
    product_price = product.price * 100
    {
      id: "li_#{SecureRandom.base58(24)}",
      object: "item",
      amount_discount: 0,
      amount_subtotal: product_price,
      amount_tax: 0,
      amount_total: product_price,
      currency: "twd",
      description: product.name,
      price: stripe_price_for(product),
      quantity: cart_item.amount
    }
  end

  # @param [Product] product
  def stripe_price_for(product)
    product_price = product.price * 100
    {
      id: product.stripe_price_id,
      object: "price",
      active: true,
      billing_scheme: "per_unit",
      created: 1661670251,
      currency: "twd",
      custom_unit_amount: nil,
      livemode: false,
      lookup_key: nil,
      metadata: {},
      nickname: nil,
      product: product.sku, # identifier
      recurring: nil,
      tax_behavior: "unspecified",
      tiers_mode: nil,
      transform_quantity: nil,
      type: "one_time",
      unit_amount: product_price,
      unit_amount_decimal: product_price.to_s
    }
  end
end
