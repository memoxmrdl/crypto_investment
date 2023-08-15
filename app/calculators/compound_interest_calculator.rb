# frozen_string_literal: true

class CompoundInterestCalculator
  def initialize(period:, amount:, interest_rate:, crypto_price:)
    @period = period
    @amount = amount
    @crypto_price = crypto_price
    @interest_rate = interest_rate
  end

  def self.generate(period:, amount:, interest_rate:, crypto_price:)
    new(period:, amount:, interest_rate:, crypto_price:).generate
  end

  def generate
    period.each_with_object([]) do |number, profits|
      @current_investment_calculator_result = {}

      @current_investment_calculator_result[:number] = number
      @current_investment_calculator_result[:amount] = amount.round(2)
      @current_investment_calculator_result[:crypto_amount] = crypto_amount

      @previous_investment_calculator_result = @current_investment_calculator_result

      profits << @current_investment_calculator_result
    end
  end

  private

  def period
    @period.is_a?(Range) ? @period : 1..@period
  end

  def interest_rate_monthly
    (@interest_rate / period.last) / 100.0
  end

  def compound_interest
    (1 + interest_rate_monthly)
  end

  def amount
    if @previous_investment_calculator_result
      @previous_investment_calculator_result.fetch(:amount, 0) * compound_interest
    else
      @amount * compound_interest
    end
  end

  def crypto_amount
    @current_investment_calculator_result[:amount] / @crypto_price
  end
end
