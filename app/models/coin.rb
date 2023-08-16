# frozen_string_literal: true

class Coin < ApplicationRecord
  INTEREST_RATE_DEFAULTS = {
    bitcoin: 60.0,
    ethereum: 36.0
  }.with_indifferent_access

  validates :slug, :price, presence: true
  validates :slug, uniqueness: true
end
