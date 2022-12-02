FactoryBot.define do
  factory :cart do
    association :user
    status { "pending" }

    trait :with_some_items do
      after(:create) do |cart|
        create_list(:cart_item, 5, cart: cart)
      end
    end
  end
end
