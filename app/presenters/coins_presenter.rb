# frozen_string_literal: true

class CoinsPresenter < ApplicationPresenter
  attributes coins: :coins

  def coins
    @data.fetch("data", [])
  end
end
