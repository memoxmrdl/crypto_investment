# frozen_string_literal: true

require "test_helper"

class CompoundInterestCalculatorTest < ActionDispatch::IntegrationTest
  def setup
    @subject = CompoundInterestCalculator
    @crypto = coins(:bitcoin)
    @capital_amount = 500.0
    @annual = 12
  end

  def test_it_generates
    result = @subject.generate(
      period: @annual,
      amount: @capital_amount,
      interest_rate: @crypto.interest_rate.to_f,
      crypto_price: @crypto.price.to_f
    )

    interest_rate_montly = (@crypto.interest_rate.to_f / 100.0) / @annual

    real_amount = (@capital_amount * (1 + interest_rate_montly) ** @annual).round(2)

    assert_equal real_amount, result.last[:amount]
  end
end
