# frozen_string_literal: true

module Schemas
  module Ingredients
    def self.schema
      {
        ingredients_response: {
          type: :object,
          properties: {
            servings: { type: :integer },
            ingredients: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  ingredient: { type: :string },
                  amounts: {
                    type: :object,
                    additionalProperties: { type: :number }
                  }
                },
                required: %w[ingredient amounts],
                additionalProperties: false
              }
            }
          },
          required: %w[servings ingredients],
          additionalProperties: false
        },
        put_ingredients: {
          type: :object,
          properties: {
            serving_size: { type: :integer },
            ingredients: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  ingredient: { type: :string }
                },
                required: ['ingredient']
              }
            }
          },
          required: %w[serving_size ingredients]
        },
        ingredient_error_response: {
          oneOf: [
            {
              type: :object,
              properties: {
                errors: { type: :string }
              },
              required: ['errors']
            },
            {
              type: :object,
              properties: {
                errors: {
                  type: :array,
                  items: {
                    type: :string
                  }
                }
              },
              required: ['errors']
            }
          ]
        }
      }
    end
  end
end
