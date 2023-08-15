# frozen_string_literal: true

class CalculateInvestment
  include Interactor

  def call
    investment_calculator
    find_bitcoin
    find_ethereum
    calculate_investment
  end

  private

  def investment_calculator
    context.investment_calculator = InvestmentCalculator.new(context.attributes)
    context.fail! unless context.investment_calculator.valid?
  end

  def find_bitcoin
    @bitcoin = Coin.find_by_slug("bitcoin")
  end

  def find_ethereum
    @ethereum = Coin.find_by_slug("ethereum")
  end

  def calculate_investment
    context.investment_calculator.bitcoin_results = calculate_investment_on_bitcoin
    context.investment_calculator.ethereum_results = calculate_investment_on_ethereum
  rescue
    context.investment_calculator.errors.add(:amount, :invalid)
    context.fail!
  end

  def calculate_investment_on_bitcoin
    installments = CompoundInterestCalculator.generate(
      period: 1..12,
      crypto_price: @bitcoin.price.to_f,
      amount: context.investment_calculator.amount,
      interest_rate: @bitcoin.interest_rate
    )

    installments.each_with_object([]) do |installment, collection|
      collection << InvestmentCalculatorResult.new(installment)
    end
  end

  def calculate_investment_on_ethereum
    installments = CompoundInterestCalculator.generate(
      period: 1..12,
      crypto_price: @ethereum.price.to_f,
      amount: context.investment_calculator.amount,
      interest_rate: @ethereum.interest_rate
    )

    installments.each_with_object([]) do |installment, collection|
      collection << InvestmentCalculatorResult.new(installment)
    end
  end
end
