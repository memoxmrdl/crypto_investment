# frozen_string_literal: true

class FetchCoinsService < ApplicationService
  private

  def repository_class
    CryptoCurrencyListing
  end

  def presenter_class
    CoinsPresenter
  end
end
