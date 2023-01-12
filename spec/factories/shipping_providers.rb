FactoryBot.define do
  factory :shipping_provider do
    association :region, factory: :shipping_region
    name { Faker::Company.name }
    tax_id { Faker::Company.ein }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    contact_number { Faker::PhoneNumber.phone_number }
  end
end
