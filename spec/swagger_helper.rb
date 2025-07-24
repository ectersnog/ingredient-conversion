# frozen_string_literal: true

require 'rails_helper'
Dir[File.join(__dir__, 'schemas', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s
  config.openapi_all_properties_required = true

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        schemas: [
          Schemas::Ingredients.schema
        ].inject(:merge)
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }
  config.openapi_format = :yaml
end
