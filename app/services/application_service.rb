# frozen_string_literal: true

#
# Interface for services
#
class ApplicationService
  #
  # Stores the result of a service call.
  #
  class Result
    attr_reader :output, :status, :message
    #
    # @param [Object] output from service call
    # @param [Symbol] status in `Rack::Utils::SYMBOL_TO_STATUS_CODE`
    # @param [String|NilClass] message for flash
    #
    def initialize(output, status, message = nil)
      @output = output
      @status = status
      @message = message
    end

    def flash_key
      @status == :ok ? :notice : :alert
    end

    def for_response
      yield(status, flash_key, message)
    end
  end

  attr_reader :result

  # @return [ApplicationService::Result]
  def call = raise(NotImplementedError)

  def complete(output, status, message = nil)
    @result = Result.new(output, status, message)
  end

  # @return (see #call)
  def self.call(*args)
    new(*args).call
  end
end
