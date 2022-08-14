# frozen_string_literal: true

ShippingRegion.where.not(code: "TW").each do |region|
  provider = ShippingProvider.create!(
    name: "Ruby Express #{region.code}",
    tax_id: Faker::Company.ein,
    address: Faker::Address.full_address,
    email: Faker::Internet.email,
    contact_number: Faker::PhoneNumber.phone_number,
    region: region
  )
  provider.shipping_methods.create!(
    name: "standard_shipping",
    fee: 1000
  )
end
