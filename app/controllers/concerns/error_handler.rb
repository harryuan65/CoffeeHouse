# frozen_string_literal: true

#
# Catch and response to error for general cases
#
module ErrorHandler
  extend ActiveSupport::Concern

  def self.included(origin_class)
    origin_class.class_eval do
      rescue_from StandardError, with: :server_error_handler
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_handler
      rescue_from ActionController::RoutingError, with: :route_not_found_handler
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_handler
    end
  end

  private

  def record_not_found_handler(exception)
    handle error_message: exception.to_s, status: :not_found
  end

  def record_invalid_handler(exception)
    handle error_message: exception.to_s, status: :bad_request
  end

  def server_error_handler(exception)
    error_details = "#{exception}\n#{exception.backtrace[0..3]}"
    logger.fatal error_details
    handle error_message: "#{exception}\n#{error_details}", status: :internal_server_error
  end

  def route_not_found_handler(exception)
    handle error_message: exception.to_s, status: :not_found
  end

  def handle(error_message:, status:)
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = error_message and render(partial: "shared/flash", status: status)
      end
      format.html do
        flash[:alert] = error_message and redirect_to(root_path)
      end
    end
  end
end
