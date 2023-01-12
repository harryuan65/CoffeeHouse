FactoryBot.define do
  factory :shipping_method do
    association :provider, factory: :shipping_provider
    name { "delivery" }
    fee { 100 }
  end
end
