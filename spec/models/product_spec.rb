# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :uuid             not null, primary key
#  name            :string           not null
#  sku             :string           not null
#  image_url       :string
#  category        :string           default("consumable"), not null
#  price           :float            not null
#  available_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
