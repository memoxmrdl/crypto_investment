# frozen_string_literal: true

class CsvExport < ApplicationExport
  private

  def headers
    [:number, :bitcoin_amount, :bitcoin_crypto_amount, :ethereum_amount, :ethereum_crypto_amount]
  end

  def collection_mapped
    12.times.each_with_object([]) do |number, collection|
      item = OpenStruct.new(number: number + 1)

      Constants::Coins::DEFAULTS.each do |coin|
        Constants::InvestmentCalculatorResults::CSV_ATTRIBUTES_DEFAULTS.each do |attribute|
          value = @collection.send(coin)[number - 1].send(attribute)

          item.send("#{coin}_#{attribute}=", value)
        end
      end

      collection << item
    end
  end
end
