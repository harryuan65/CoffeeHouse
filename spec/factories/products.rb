# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Coffee Bean #{n}" }
    sequence(:sku) { |n| "coffee_bean_#{n}" }
    category { "consumable" }
    price { 300.0 }
    stripe_price_id { "price_#{SecureRandom.base58(24)}" }
    available_count { 5 }
  end
end
