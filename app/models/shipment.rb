# == Schema Information
#
# Table name: shipments
#
#  id         :uuid             not null, primary key
#  region_id  :uuid             not null
#  order_id   :uuid             not null
#  name       :string
#  email      :string
#  city       :string
#  address    :string
#  status     :string
#  started_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
#
# Shipment information for an order
#
class Shipment < ApplicationRecord
  belongs_to :region, class_name: "ShippingRegion", foreign_key: "region_id"
  belongs_to :order
end
