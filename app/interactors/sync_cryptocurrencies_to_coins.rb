# frozen_string_literal: true

class SyncCryptocurrenciesToCoins
  include Interactor

  def call
    sync_cryptocurrencies_to_coins
  end

  private

  def sync_cryptocurrencies_to_coins
    fetch_cryptocurrencies.each do |cryptocurrency|
      @current_cryptocurrency = cryptocurrency
      @current_coin = Coin.find_or_create_by(slug: @current_cryptocurrency.dig("slug"))

      update_current_coin
    end
  end

  def fetch_cryptocurrencies
    @_fetch_cryptocurrencies ||= FetchCryptocurrenciesService.fetch(resource: OpenStruct.new(coins: [])).coins
  rescue => e
    Rails.logger.error("Error fetching cryptocurrencies: #{e}")

    []
  end

  def update_current_coin
    @current_coin = presenter_class.new(resource: @current_coin).present(data: @current_cryptocurrency)
    @current_coin.interest_rate = Constants::Coins::INTEREST_RATE_DEFAULTS.fetch(@current_coin.slug, 0.0)
    @current_coin.save
  end

  def presenter_class
    CoinPresenter
  end
end
