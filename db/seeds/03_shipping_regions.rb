data_path = Rails.root.join("db/seeds/data/shipping_regions.yml")
regions = Psych.safe_load(File.read(data_path))
regions = regions.map { |h|
  h[:id] = SecureRandom.uuid
  h.symbolize_keys
}
ShippingRegion.insert_all(regions)
