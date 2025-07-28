# frozen_string_literal: true

require 'ollama-ai'

module Ollama
  class IngredientUnits < ApplicationOperation
    Ingredient_info = Data.define(:ingredient, :base_unit, :measurements)
    Measurement_info = Data.define(:unit, :base_equivalent)

    def call(ingredient:)
      client = step client_connect
      response = step retrieve_info(client, ingredient)
      step parse_response(response)
    end

    private

    def messages(ingredient)
      raw = Rails.root.join("lib/ollama/messages.txt").read
      parsed = raw.split(/^(\w+):/).reject(&:empty?).each_slice(2).map do |role, content|
        { role: role.strip, content: content.strip }
      end

      parsed + [{ role: "user", content: ingredient }]
    end

    def client_connect
      Success(
        Ollama.new(
          credentials: { address: 'http://localhost:11434' },
          options: { server_sent_events: true }
        )
      )
    end

    def retrieve_info(client, ingredient)
      response = client.chat(
        {
          model: 'deepseek-r1:1b',
          messages: messages(ingredient),
          stream: false
        })
      return Failure(response[0]["message"]["content"]["error"]) if check_failure?(response)

      Success(response)
    end

    def check_failure?(response)
      response[0]["message"]["content"].match?(/error/)
    end

    def parse_response(response)
      parsed = JSON.parse(response[0]["message"]["content"])
      measurements = parsed["units"]["common_measurements"].map do |unit|
        Measurement_info.new(
          unit: unit["unit"],
          base_equivalent: unit["base_equivalent"])
      end
      Success(
        Ingredient_info.new(
          ingredient: parsed["ingredient"],
          base_unit: parsed["units"]["base_unit"],
          measurements:)
      )
    rescue JSON::ParserError
      Failure()
    end
  end
end
