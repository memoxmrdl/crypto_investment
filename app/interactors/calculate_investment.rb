# frozen_string_literal: true

class CalculateInvestment
  include Interactor

  def call
    investment_calculator
    calculate_investment
  end

  private

  def investment_calculator
    context.investment_calculator = InvestmentCalculator.new(context.attributes)
    context.fail! unless context.investment_calculator.valid?
  end

  def calculate_investment
    calculate_investment_coins_defaults
  rescue => e
    Rails.logger.error(e)

    context.investment_calculator.errors.add(:amount, :invalid)
    context.fail!
  end

  def calculate_investment_coins_defaults
    context.investment_calculator.investment_calculator_results = OpenStruct.new

    Constants::Coins::DEFAULTS.each do |coin|
      @current_coin = coin
      @current_coin = Coin.find_by_slug(@current_coin)

      collection = generate_investment_calculate_results

      context.investment_calculator.investment_calculator_results.send("#{@current_coin.slug}=", collection)
    end
  end

  def generate_investment_calculate_results
    investment_calculator_results = CompoundInterestCalculator.generate(
      period: 1..12,
      crypto_price: @current_coin.price.to_f,
      interest_rate: @current_coin.interest_rate.to_f,
      amount: context.investment_calculator.amount
    )

    investment_calculator_results.each_with_object([]) do |investment_calculator_result, collection|
      collection << InvestmentCalculatorResult.new(investment_calculator_result.merge(coin: @current_coin.slug))
    end
  end
end
