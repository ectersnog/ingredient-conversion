# frozen_string_literal: true

module Ingredients
  class Process < ApplicationOperation
    def call(ingredients:, serving_size:)
      ingredients = step split(ingredients)
      step combine_ingredients(ingredients, serving_size)
    end

    private

    def combine_ingredients(ingredients, serving_size)
      totals = ingredients.each_with_object(Hash.new(0)) do |item, result|
        result[item.name] += Measurements.to_tsp(item.amount, item.unit)
      end

      result_array = totals.map do |name, total|
        # { name:, serving_size:, quantity: Measurements.from_tsp(total * serving_size) }
        Ingredient_to_serving.new(name:, amounts: Measurements.from_tsp(total * serving_size))
      end
      Success(Ingredient_with_serving.new(servings: serving_size, ingredients: result_array))
    end

    def split(ingredients)
      parsed_ingredients = []
      ingredients.each do |item|
        begin
          parsed = Ingreedy.parse(item[:ingredient])
        rescue Ingreedy::ParseFailed, Parslet::ParseFailed
          return Failure("Unable to parse ingredient: #{item[:ingredient]}")
        end
        parsed_ingredients.push(
          Ingredient.new(
            name: parsed[:ingredient],
            unit: parsed[:unit],
            amount: parsed[:amount]
          )
        )
      end
      Success(parsed_ingredients)
    end
  end
end
