# frozen_string_literal: true

class CryptocurrenciesPresenter < ApplicationPresenter
  attributes coins: :coins

  def coins
    @data.fetch("data", [])
  end
end
