# frozen_string_literal: true

class ApplicationExport
  def initialize(headers: [], collection: [], i18n_scope: nil)
    @headers = headers
    @collection = collection
    @i18n_scope = i18n_scope
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << i18n_headers

      collection_mapped.each do |item|
        csv << headers.map { |header| item.send(header) }
      end
    end
  end

  private

  def headers
    @headers
  end

  def collection_mapped
    @collection
  end

  def i18n_headers
    return headers unless @i18n_scope

    headers.map { |header| I18n.t(header, scope: "exports.csv.#{@i18n_scope}") }
  end
end
