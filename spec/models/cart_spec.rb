# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  status     :string           default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Cart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
