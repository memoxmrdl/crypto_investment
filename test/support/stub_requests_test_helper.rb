# frozen_string_literal: true

module StubRequestsTestHelper
  def stub_request_coinmarketcap_cryptocurrency_listings_latest(status: 200, body: nil)
    body ||= file_fixture("coinmarketcap/GET-200-crytocurrency-listings-latest").read

    stub_request(:get, "https://test.coinmarketcap.com/v1/cryptocurrency/listings/latest").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby',
          'X-Cmc-Pro-Api-Key'=>Rails.configuration.coinmarketcap[:api_key]
        }).
        to_return(status:, body:, headers: {})
  end
end
