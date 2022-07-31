# frozen_string_literal: true

#
# Allow strings themselves as enum
#
module StringEnum
  extend ActiveSupport::Concern

  module_function

  #
  # @param [Array<String>] types strings to map to enum
  #
  def string_enum(types)
    types.zip(types).to_h
  end
end
