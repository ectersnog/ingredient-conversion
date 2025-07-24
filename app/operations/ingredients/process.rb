# frozen_string_literal: true

module Ingredients
  # Splits ingredients into Ingredient data type. Combines like ingredients
  # into Ingredient_to_serving data type. Returns all ingredients
  # in an Ingredient_with_serving data type
  class Process < ApplicationOperation
    # @param ingredients [Array<Hash>] List of hashes with a single `:ingredient` string key.
    # @param serving_size [Integer] Number of servings to scale the ingredient quantities to.
    # @return [Dry::Monads::Result::Success<Ingredient_return>, Dry::Monads::Result::Failure]
    # @example
    #   Ingredients::Process.call(
    #     ingredients: [
    #       1/2 pound of cabbage',
    #       2 cups of butter'
    #     ],
    #     serving_size: 2
    #   )

    def call(ingredients:, serving_size:)
      ingredients = step split(ingredients)
      step combine_ingredients(ingredients, serving_size)
    end

    private

    def combine_ingredients(ingredients, serving_size)
      totals = ingredients.each_with_object(Hash.new(0)) do |item, result|
        result[item.name] += Measurements.to_tsp(item.unit) * item.amount
      end

      result_array = totals.map do |name, total|
        IngredientWithServing.new(name:, amount: Measurements.from_tsp((total * serving_size).to_i))
      end
      Success(IngredientReturn.new(servings: serving_size, ingredients: result_array))
    end

    def split(ingredients)
      parsed_ingredients = []
      ingredients.each do |item|
        parsed = Ingreedy.parse(item)
        parsed_ingredients.push(
          Ingredient.new(
            name: parsed[:ingredient],
            unit: parsed[:unit],
            amount: parsed[:amount]
          )
        )
      end
      Success(parsed_ingredients)
    rescue Ingreedy::ParseFailed, Parslet::ParseFailed
      Failure("Unable to parse ingredient")
    end
  end
end
