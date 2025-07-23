# frozen_string_literal: true

json.ingredients do
  json.partial! 'ingredient', collection: ingredients, as: :ingredient
end
