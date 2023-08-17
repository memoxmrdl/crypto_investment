# frozen_string_literal: true

class FetchCryptocurrenciesService < ApplicationService
  private

  def repository_class
    Coinmarketcap::CryptocurrenciesLatestRepository
  end

  def presenter_class
    CryptocurrenciesPresenter
  end
end
