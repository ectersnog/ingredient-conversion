# frozen_string_literal: true

module V1
  class IngredientsController < ApplicationController
    def combine
      result = Ingredients::Process.call(ingredients: params[:ingredients], serving_size: params[:serving_size])
      if result.success?
        render locals: { ingredients: result.success }
      else
        render json: { errors: result.failure }, status: :unprocessable_entity
      end
    end
  end
end
