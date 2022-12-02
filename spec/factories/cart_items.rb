FactoryBot.define do
  factory :cart_item do
    association :cart
    association :product
    amount { 1 }
  end
end
