# frozen_string_literal: true

class InvestmentCalculatorResult
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend ActiveModel::Translation

  attribute :coin, :string
  attribute :number, :integer
  attribute :amount, :float, default: 0
  attribute :crypto_amount, :float, default: 0
end
