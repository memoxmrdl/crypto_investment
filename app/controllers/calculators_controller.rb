# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :sync_cryptocurrencies_to_coins

  helper_method :current_coins

  def index
    @investment_calculator = InvestmentCalculator.new
  end

  def create
    result = CalculateInvestment.call(attributes: investment_calculator_params)
    @investment_calculator = result.investment_calculator

    respond_to do |format|
      format.turbo_stream
      format.csv { send_data(export_to_csv, filename: filename) }
      format.json { send_data(export_to_json, filename: filename(format: :json)) }
    end
  end

  private

  def investment_calculator_params
    params.require(:investment_calculator).permit(:amount, :coin)
  end

  def sync_cryptocurrencies_to_coins
    return unless Coin.count.zero?

    SyncCryptocurrenciesToCoins.call
  end

  def current_coins
    Coin.where(slug: Constants::Coins::DEFAULTS)
  end

  def filename(format: :csv)
    "data-exported.#{format}"
  end

  def export_to_csv
    CsvExport.new(
      i18n_scope: :investment_calculator_result,
      collection: @investment_calculator.investment_calculator_results
    ).to_csv
  end

  def export_to_json
    @investment_calculator.investment_calculator_results.to_json
  end
end
