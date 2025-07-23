# frozen_string_literal: true

module Ingredients
  class Combine < ApplicationOperation
    def call(ingredients:)
      ingredients = step split_ingredients(ingredients:)
      step combine_ingredients(ingredients)
    end

    private

    def split_ingredients(ingredients:)
      ingredient_array = ingredients.map do |ingredient|
        { ingredient: ingredient[:ingredient], serving_size: ingredient[:serving_size] }
      end

      Success(ingredient_array)
    end

    def combine_ingredients(ingredients)
      # code here
    end
  end
end
