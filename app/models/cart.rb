# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
#
# Keeps track of users cart items, will be references by an order after purchase
#
class Cart < ApplicationRecord
  extend StringEnum
  belongs_to :user
  has_many :items, class_name: "CartItem"

  enum status: string_enum(%w[pending archived])
end
