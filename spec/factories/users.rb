# frozen_string_literal: true

require "bcrypt"

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@gmail.com" }
    stripe_customer_id { "cus_xJzC2QfXWcEHeSGEqqvgUA" }
    password { Devise.friendly_token.first(6) }
  end
end
