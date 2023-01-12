FactoryBot.define do
  factory :order do
    association :user
    status { "pending" }

    trait :with_some_items do
      after(:create) do |order|
        create_list(:order_item, 5, order: order)
      end
    end
  end
end
