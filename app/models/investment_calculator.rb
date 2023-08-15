# frozen_string_literal: true

class InvestmentCalculator
  include ActiveModel::API
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :bitcoin_results, :ethereum_results

  attribute :amount, :float

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
