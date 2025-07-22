# frozen_string_literal: true

module Ingredients
  # Data types for passing ingredient information between operations and views.

  # Represents a parsed ingredient
  # @!attribute name [String] The name of the ingredient
  # @!attribute unit [String] The unit of measurement for the ingredient
  # @!attribute amount [Float] The amount of the ingredient
  Ingredient = Data.define(:name, :unit, :amount)

  # Represents the ingredient with upscaled with serving size
  # @!attribute name [String] the name of the ingredient
  # @!attribute amount [Integer] The amount in teaspoons of the ingredient
  Ingredient_with_serving = Data.define(:name, :amount)

  # Represents the combined results of the ingredients added together
  # @!attribute ingredients [Array<Hash>] Array of hashes with the ingredients and their amounts
  # @!attribute servings [Integer] The servings that ingredients were upscaled to
  Ingredient_return = Data.define(:ingredients, :servings)
end
