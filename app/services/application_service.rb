# frozen_string_literal: true

#
# Interface for services
#
class ApplicationService
  attr_reader :result

  def call = raise(NotImplementedError)
end
