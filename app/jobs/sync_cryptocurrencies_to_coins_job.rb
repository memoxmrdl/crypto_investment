# frozen_string_literal: true

class SyncCryptocurrenciesToCoinsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SyncCryptocurrenciesToCoins.call
  end
end
