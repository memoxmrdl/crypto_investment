# frozen_string_literal: true

module Coinmarketcap
  class CryptocurrenciesLatestRepository < BaseRepository
    private

    def current_path
      "/cryptocurrency/listings/latest"
    end
  end
end
