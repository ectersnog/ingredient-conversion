# frozen_string_literal: true

module V1
  class IngredientsController < ApplicationController
    def combine
      result = Ingredients::Combine.call(ingredients: params[:data])
      if result.success?
        render locals: { ingredients: result.success }
      else
        render json: { errors: result.failure }, status: :unprocessable_entity
      end
    end
  end
end
