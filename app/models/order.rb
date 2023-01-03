# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :uuid             not null, primary key
#  user_id      :uuid             not null
#  product_id   :uuid             not null
#  payment_type :string           not null
#  payment_id   :uuid             not null
#  status       :string           default("pending"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Order < ApplicationRecord
  extend StringEnum
  belongs_to :user
  belongs_to :payment, polymorphic: true
  has_many :items, class_name: "OrderItem"

  enum status: string_enum(%w[pending completed canceled failed])
  enum category: string_enum(%w[consumable subscription])
end
