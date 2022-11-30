# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Coffee Bean #{n}" }
    sequence(:sku) { |n| "coffee_bean_#{n}" }
    category { "consumable" }
    price { 300.0 }
  end
end
