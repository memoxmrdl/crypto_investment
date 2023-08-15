# frozen_string_literal: true

class InvestmentCalculatorResult
  include ActiveModel::API
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :number, :integer
  attribute :amount, :float, default: 0
  attribute :crypto_amount, :float, default: 0
end
