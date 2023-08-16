# frozen_string_literal: true

class InvestmentCalculator
  include ActiveModel::API
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :investment_calculator_results

  attribute :coin, :string
  attribute :amount, :float

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
