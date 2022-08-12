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
class Product < ApplicationRecord
  has_rich_text :content
  after_create_commit { broadcast_append_to "products" }
  after_update_commit { broadcast_replace_to "products" }
  after_destroy_commit { broadcast_remove_to "products" }
end
