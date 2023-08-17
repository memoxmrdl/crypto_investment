# frozen_string_literal: true

class Coin < ApplicationRecord
  validates :slug, :price, presence: true
  validates :slug, uniqueness: true

  scope :defaults, -> { where(slug: Constants::Coins::DEFAULTS) }
end
