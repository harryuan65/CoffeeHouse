# frozen_string_literal: true

default_region = ShippingRegion.find_or_create_by!(
  name: "Taiwan",
  dial_code: "+886",
  code: "TW"
)
data_path = Rails.root.join("db/seeds/data/tw_fake_providers.yml")
providers = Psych.safe_load(File.read(data_path))
providers.each do |provider_hash|
  provider_hash.symbolize_keys!
  shipping_methods = provider_hash.delete(:shipping_methods)
  provider = ShippingProvider.create!(
    name: provider_hash[:name],
    tax_id: provider_hash[:tax_id], # randomly generated
    address: provider_hash.values_at(:street, :city, :area, :country).join(", "),
    email: "#{provider_hash[:name].dasherize}@gmail.com",
    contact_number: "#{provider_hash[:country_calling_code]}#{provider_hash[:phone_number]}",
    region: default_region
  )
  shipping_methods.each { |mtd| provider.shipping_methods.create!(mtd) }
end
