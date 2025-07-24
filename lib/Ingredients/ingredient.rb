# frozen_string_literal: true

module Ingredients
  # Data types for passing ingredient information between operations and views.

  # Represents a parsed ingredient
  # @!attribute amount [Float] The amount of the ingredient
  # @!attribute name [String] The name of the ingredient
  # @!attribute unit [String] The unit of measurement for the ingredient
  Ingredient = Data.define(:amount, :name, :unit)

  # Represents the ingredient with upscaled with serving size
  # @!attribute amount [Integer] The amount in teaspoons of the ingredient
  # @!attribute name [String] the name of the ingredient
  IngredientWithServing = Data.define(:amount, :name)

  # Represents the combined results of the ingredients added together
  # @!attribute ingredients [Array<Hash>] Array of hashes with the ingredients and their amounts
  # @!attribute servings [Integer] The servings that ingredients were upscaled to
  IngredientReturn = Data.define(:ingredients, :servings)
end
