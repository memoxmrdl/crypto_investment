# frozen_string_literal: true

class CryptocurrencyPresenter < ApplicationPresenter
  attributes name: :name,
    symbol: :symbol,
    slug: :slug,
    price: :price

  def name
    @data.dig("name")
  end

  def symbol
    @data.dig("symbol")
  end

  def slug
    @data.dig("slug")
  end

  def price
    @data.fetch("quote", {}).fetch("USD", {}).fetch("price", 0)
  end
end
