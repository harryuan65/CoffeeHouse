#
# Implements airbnb validator logic
#
module Validator
  extend ActiveSupport::Concern

  # Contains more key than expected
  ExcessiveKeyError = Class.new(StandardError)
  # Missing key Error
  MissingKeyError = Class.new(StandardError)
  # Validation Error
  ValidationError = Class.new(StandardError)

  # Validate options
  class OptionValidator
    attr_reader :hash

    def initialize(hash, strict: nil)
      @hash = hash
      @strict = strict
      @key_constraints = {}
      @errors = []
    end

    def validate(key, is_a:, **other_constraints)
      @key_constraints[key] = {
        is_a: is_a, **other_constraints
      }
    end

    def perform
      excessive_key_check if @strict
      constraint_check
      report
    end

    private

    def excessive_key_check
      excessive_keys = hash.keys - @key_constraints.keys
      @errors << ExcessiveKeyError.new("Excessive keys detected [#{excessive_keys.join(",")}]") if excessive_keys.any?
    end

    def constraint_check
      @key_constraints.each do |key, constraints|
        if hash.has_key?(key)
          validate_type(key, constraints)
        elsif constraints[:required]
          @errors << MissingKeyError.new("Key \"#{key}\" is required")
        end
      end
    end

    def report
      if @errors.any?
        raise ValidationError, @errors.map { |exception| "#{exception.class}: #{exception.message}" }.join("\n")
      end
    end

    private

    def validate_type(key, constraints)
      value = hash[key]

      raise ArgumentError, ":is_a should be specified" unless (kind = constraints[:is_a])

      if !value.is_a?(kind)
        @errors << TypeError.new("#{key} is not a #{kind}")
      elsif kind == Array
        validate_array_item(key, constraints[:of])
      end
    end

    # @param [Array] value: known array to be validated
    # @param [Object] item_kind: the class that each array value should be
    #
    def validate_array_item(key, item_kind)
      value = hash[key]
      raise ArgumentError, "#{key}: \":of\" should be specified when validating an array" unless item_kind

      unless value.all? { |sub_val| sub_val.is_a?(item_kind) }
        @errors << TypeError.new("#{key}: Not all items are #{item_kind}")
      end
    end
  end

  module_function

  # @param [Hash] hash
  # @yield [Validator] option_validator
  def validate_arg(hash, strict: nil)
    option_validator = OptionValidator.new(hash, strict: strict)
    yield(option_validator)
    option_validator.perform
  end
end
