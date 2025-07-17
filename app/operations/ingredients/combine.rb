# frozen_string_literal: true

module Ingredients
  class Combine < ApplicationOperation
    def call(ingredients:)
      step combine_ingredients(ingredients)
    end

    private

    def combine_ingredients(ingredients)
      totals = ingredients.each_with_object(Hash.new(0)) do |item, result|
        result[item[:name]] += item[:serving_size].to_i
      end

      result_array = totals.map do |name, total|
        { name:, serving_size: total }
      end
      Success(result_array)
    end
  end
end
