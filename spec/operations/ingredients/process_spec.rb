# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredients::Process do
  describe "#call" do
    subject(:result) { described_class.new.call(ingredients:, serving_size:) }

    context 'with serving size of 1' do
      let(:ingredients) do
        [
          '1 ounce of water',
          '1 cup of flour'
        ]
      end
      let(:serving_size) { 1 }

      it 'parses the ingredients and returns proper values' do
        expect(result).to be_success
        expect(result.success).to be_a(Ingredients::IngredientReturn)

        expect(result.success.ingredients.map(&:name)).to eq(%w[water flour])
        expect(result.success.ingredients[0].amount).to eq("ounce" => 1)
        expect(result.success.ingredients[1].amount).to eq("cup" => 1)
      end
    end

    context 'with serving size of 2' do
      let(:ingredients) do
        [
          '1 ounce of water',
          '1 cup of flour',
          '3/4 cup of sugar'
        ]
      end
      let(:serving_size) { 2 }

      it 'parses the ingredients and returns proper values' do
        expect(result).to be_success
        expect(result.success).to be_a(Ingredients::IngredientReturn)

        expect(result.success.ingredients.map(&:name)).to eq(%w[water flour sugar])
        expect(result.success.ingredients[0].amount).to eq("1/4 cup" => 1)
        expect(result.success.ingredients[1].amount).to eq("pint" => 1)
        expect(result.success.ingredients[2].amount).to eq("1 1/2 cup" => 1)
      end
    end
  end
end
