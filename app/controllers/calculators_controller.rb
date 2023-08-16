# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :refresh_coins

  COINS_DEFAULT = [:bitcoin, :ethereum]

  helper_method :current_coins

  def index
    @investment_calculator = InvestmentCalculator.new
  end

  def create
    result = CalculateInvestment.call(attributes: investment_calculator_params)
    @investment_calculator = result.investment_calculator

    respond_to do |format|
      format.turbo_stream
      format.csv { send_data(result.export_to_csv, filename: filename) }
      format.json { send_data(result.export_to_json, filename: filename(format: :json)) }
    end
  end

  private

  def investment_calculator_params
    params.require(:investment_calculator).permit(:amount, :coin)
  end

  def refresh_coins
    return unless Coin.count.zero?

    UpdateCoins.call
  end

  def current_coins
    Coin.where(slug: COINS_DEFAULT)
  end

  def filename(format: :csv)
    "data.#{format}"
  end
end
