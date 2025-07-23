# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe "/v1/ingredients" do
  path '/v1/ingredients' do
    put('parse ingredients') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :ingredient_params, in: :body, required: true, schema: {
        '$ref' => '#/components/schemas/put_ingredients'
      }

      let(:ingredient_params) do
        {
          serving_size: 1,
          ingredients: [
            '1 ounce of water',
            '1 cup of flour'
          ]
        }
      end

      response '200', 'parsed successfully' do
        schema '$ref' => '#/components/schemas/ingredients_response'
        run_test!
      end

      response '422', 'invalid request' do
        let(:ingredient_params) do
          {
            serving_size: nil,
            ingredients: [
              'aaaa aaa aaa'
            ]
          }
        end
        schema '$ref' => '#/components/schemas/ingredient_error_response'
        run_test!
      end
    end
  end
end
