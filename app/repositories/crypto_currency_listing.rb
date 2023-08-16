# frozen_string_literal: true

class CryptoCurrencyListing
  include HTTParty

  base_uri Rails.configuration.coinmarketcap[:api_url]

  format :json

  def initialize(path:)
    @path = path
  end

  def self.retrieve
    new(path: "/cryptocurrency/listings/latest").retrieve
  end

  def retrieve
    self.class.get(@path, options)
  end

  private

  def options
    {
      headers: {
        "X-CMC_PRO_API_KEY" => Rails.configuration.coinmarketcap[:api_key]
      }
    }
  end
end
