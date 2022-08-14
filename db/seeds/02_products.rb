data_path = Rails.root.join("db/seeds/data/products.yml")
products = Psych.safe_load(File.read(data_path), [Symbol])

products.each do |hash|
  content = hash.delete("content")
  next if Product.exists?(hash)

  product = Product.create!(hash)
  product.content.update!(body: ActionText::Content.new(content))
end
