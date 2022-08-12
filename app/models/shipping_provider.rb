# == Schema Information
#
# Table name: shipping_providers
#
#  id             :uuid             not null, primary key
#  region_id      :uuid             not null
#  name           :string
#  tax_id         :string
#  address        :string
#  email          :string
#  contact_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
#
# Companies that provide shipment service
#
class ShippingProvider < ApplicationRecord
  has_many :shipping_methods, foreign_key: "provider_id"
  belongs_to :region, class_name: "ShippingRegion", foreign_key: "region_id"
end
