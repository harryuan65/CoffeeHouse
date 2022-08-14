# frozen_string_literal: true

Dir[Rails.root.join("db/seeds/*.rb")].each do |file|
  puts "Processing #{file}"
  require_relative file
end
