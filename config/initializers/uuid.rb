# frozen_string_literal: true

# Add uuid support. Reference: https://pawelurbanek.com/uuid-order-rails
# example: rails g model admin id:uuid name:string
Rails.application.config.generators do |generator|
  generator.orm :active_record, primary_key_type: :uuid
end
