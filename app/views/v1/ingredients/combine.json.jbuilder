# frozen_string_literal: true

json.servings ingredients.servings
json.ingredients do
  json.partial! 'ingredient', collection: ingredients.ingredients, as: :ingredient
end
