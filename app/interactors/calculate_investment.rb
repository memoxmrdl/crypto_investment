# frozen_string_literal: true

class CalculateInvestment
  include Interactor

  COINS_DEFAULTS = ["bitcoin", "ethereum"]
  CSV_ATTRIBUTES_DEFAULTS = [:amount, :crypto_amount]

  def call
    investment_calculator
    calculate_investment
    export_data
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

    COINS_DEFAULTS.each do |coin|
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

  def export_data
    context.export_to_csv = export_to_csv
    context.export_to_json = export_to_json
  end

  def export_to_csv
    CsvExport.new(
      headers: csv_headers,
      collection: csv_export_collection,
      i18n_scope: :investment_calculator_result
    ).to_csv
  end

  def export_to_json
    export_collection.to_json
  end

  def export_collection
    context.investment_calculator.investment_calculator_results
  end

  def csv_headers
    [:number, :bitcoin_amount, :bitcoin_crypto_amount, :ethereum_amount, :ethereum_crypto_amount]
  end

  def csv_export_collection
    12.times.each_with_object([]) do |number, collection|
      item = OpenStruct.new(number: number + 1)

      COINS_DEFAULTS.each do |coin|
        CSV_ATTRIBUTES_DEFAULTS.each do |attribute|
          value = export_collection.send(coin)[number - 1].send(attribute)

          item.send("#{coin}_#{attribute}=", value)
        end
      end

      collection << item
    end
  end
end
