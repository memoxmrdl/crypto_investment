# frozen_string_literal: true

require "test_helper"

class FetchCoinsServiceTest < ActionDispatch::IntegrationTest
  include StubRequestsTestHelper

  def setup
    @subject = FetchCoinsService
  end

  def test_it_fetch_coins
    stub_request_coinmarketcap_cryptocurrency_listings_latest

    result = @subject.fetch(resource: OpenStruct.new)

    assert_equal 100, result.coins.length
  end

  def test_it_fails_when_is_400_range_responses
    stub_request_coinmarketcap_cryptocurrency_listings_latest(
      status: 429,
      body: file_fixture("coinmarketcap/401-Unauthorized").read
    )

    result = @subject.fetch(resource: OpenStruct.new)

    assert_equal 0, result.coins.length
  end
end
