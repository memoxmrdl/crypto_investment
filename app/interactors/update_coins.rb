# frozen_string_literal: true

class UpdateCoins
  include Interactor

  def call
    fetch_coins
    update_coins
  end

  private

  def fetch_coins
    @_fetch_coins ||= FetchCoinsService.fetch(resource: OpenStruct.new).coins
  rescue => e
    Rails.logger.error("Error fetching coins: #{e}")

    []
  end

  def update_coins
    fetch_coins.each do |coin|
      @fetch_coin = coin
      @current_coin = Coin.find_or_create_by(slug: @fetch_coin.dig("slug"))

      update_coin
    end
  end

  def update_coin
    @current_coin = CoinPresenter.new(resource: @current_coin).present(data: @fetch_coin)
    @current_coin.interest_rate = Coin::INTEREST_RATE_DEFAULTS.fetch(@current_coin.slug, 0.0)
    @current_coin.save
  end
end
