# frozen_string_literal: true

class Measurements
  # Class to convert an ingredient amount from unity to teaspoon and back again.
  unless defined?(TEASPOON_CONVERSION)
    TEASPOON_CONVERSION = {
      "gallon" => 768,
      "quart" => 192,
      "pint" => 96,
      "pound" => 92,
      "1 3/4 cup" => 84,
      "1 1/2 cup" => 72,
      "1 1/4 cup" => 60,
      "cup" => 48,
      "3/4 cup" => 36,
      "1/2 cup" => 24,
      "1/4 cup" => 12,
      "ounce" => 6,
      "tablespoon" => 3,
      "teaspoon" => 1
    }.freeze
  end

  # Convert a unit and quantity to teaspoons for combining with other ingredient amounts.
  #
  # @param qty [Float] The original ingredient amount
  # @param unit [String] The Unit type
  # @return [Integer] The resulting amount of teaspoons
  def self.to_tsp(qty, unit)
    (TEASPOON_CONVERSION[unit.to_s] * qty).to_i
  end

  # Convert a teaspoon amount back into a human-readable amount
  #
  # @param qty [Integer] The amount to convert back from teaspoons
  # @return [Array<Hash>] The resulting amounts
  def self.from_tsp(qty)
    result = {}
    TEASPOON_CONVERSION.each do |unit, value|
      count = qty / value
      if count.positive?
        result[unit] = count
        qty %= value
      end
    end
    result
  end
end
