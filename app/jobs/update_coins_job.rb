class UpdateCoinsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UpdateCoins.call
  end
end
