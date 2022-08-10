# frozen_string_literal: true

#
# Interface for services
#
class ApplicationService
  attr_reader :result

  #
  # @return [Object] returns the instance of current service
  #
  def call = raise(NotImplementedError)
end
