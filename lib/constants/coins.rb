# frozen_string_literal: true

module Constants
  module Coins
    DEFAULTS = [:bitcoin, :ethereum]

    INTEREST_RATE_DEFAULTS = {
      bitcoin: 60.0,
      ethereum: 36.0
    }.with_indifferent_access
  end
end
