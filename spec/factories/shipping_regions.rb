FactoryBot.define do
  factory :shipping_region do
    code { Faker::Address.country_code }
    name { Faker::Address.country }
    dial_code { Faker::PhoneNumber.country_code }
  end
end
