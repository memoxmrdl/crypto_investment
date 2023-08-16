# frozen_string_literal: true

module Coinmarketcap
  class BaseRepository
    include HTTParty

    base_uri Rails.configuration.coinmarketcap[:api_url]

    format :json

    def self.retrieve
      new.retrieve
    end

    def retrieve
      self.class.get(current_path, options)
    end

    private

    def current_path
    end

    def options
      {
        headers: {
          "X-CMC_PRO_API_KEY" => Rails.configuration.coinmarketcap[:api_key]
        }
      }
    end
  end
end
