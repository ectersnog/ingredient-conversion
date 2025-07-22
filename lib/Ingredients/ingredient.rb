# frozen_string_literal: true

module Ingredients
  Ingredient = Data.define(:name, :unit, :amount)
  Ingredient_to_serving = Data.define(:name, :amounts)
  Ingredient_with_serving = Data.define(:ingredients, :servings)
end
