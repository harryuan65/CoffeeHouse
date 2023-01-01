# Utility Functions

# :reek:UtilityFunction
# Get an excerpt from seed html content. Can get alphabet and zh_tw characters.
#
# @param [String] content: ActionText::Content.to_html
#
# @return [String]
#
def action_text_content_excerpt(content)
  doc = Nokogiri::HTML(content)
  doc.xpath("//div")[1].text.match(/(?:[^\n]+)|(?:[\u4E00-\u9FFC]+)\./).to_s
end

#
# Create a stripe product for the product record, :reek:FeatureEnvy

#
# Create stripe product using product relation.
#
# @param [Product] product
# @param [String] description: short desc for stripe product
#
# @return [NilClass]
#
def create_stripe_product(product, description)
  sku, name, price = product.values_at(:sku, :name, :price)

  new_stripe_product = Stripe::Product.create(
    id: sku,
    name: name,
    description: description
  )

  price = Stripe::Price.create(
    currency: "twd",
    unit_amount: price.to_i * 100,
    product: new_stripe_product["id"]
  )

  product.update(stripe_price_id: price.id)
  puts "Created stripe product: #{new_stripe_product["name"]}"
end

# Main Seeding Logic

abort("Stripe api key is not set") unless Stripe.api_key ||= ENV["STRIPE_API_KEY"]

data_path = Rails.root.join("db/seeds/data/products.yml")
products = Psych.safe_load(File.read(data_path), [Symbol])

products.each do |hash|
  content = hash.delete("content")
  next if Product.exists?(hash)

  product = Product.create!(hash)
  product.content.update!(body: ActionText::Content.new(content))
  if (stripe_product = Stripe::Product.retrieve(product.sku))
    puts "Stripe product already exists: #{stripe_product["name"]}"
  else
    create_stripe_product(product, action_text_content_excerpt(content))
  end
end
