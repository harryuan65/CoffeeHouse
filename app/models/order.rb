#
# Record purchase
#
class Order < ApplicationRecord
  extend StringEnum
  belongs_to :user
  belongs_to :cart
  belongs_to :payment, polymorphic: true

  enum status: string_enum(%w[pending completed canceled])
  enum category: string_enum(%w[consumable subscription])
end
