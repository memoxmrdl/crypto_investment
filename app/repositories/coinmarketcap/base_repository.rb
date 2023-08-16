# frozen_string_literal: true

module Coinmarketcap
  class BaseRepository
    BASE_URI = Rails.configuration.coinmarketcap[:api_url]

    def self.retrieve
      new.retrieve
    end

    def retrieve
      HTTParty.get("#{BASE_URI}#{current_path}", options)
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
