# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1 do
    put 'ingredients', to: 'ingredients#combine'
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
