# frozen_string_literal: true

module Ingredients
  class Split < ApplicationOperation
    def call(ingredients:)
      step split(ingredients)
    end

    private

    def split(ingredients)
      parsed_ingredients = ingredients.each_with_object(Hash.new(0)) do |item, result|
        parsed = Ingreedy.parse(item[:ingredient])
        result[parsed[:ingredient]] += parsed[:amount].to_i * Measurements.convert(parsed[:amount], parsed[:unit])
      end
      Success(parsed_ingredients)
    end
  end
end
