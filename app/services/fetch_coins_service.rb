# frozen_string_literal: true

class FetchCoinsService < ApplicationService
  private

  def repository_class
    Coinmarketcap::CryptocurrenciesLatestRepository
  end

  def presenter_class
    CoinsPresenter
  end
end
