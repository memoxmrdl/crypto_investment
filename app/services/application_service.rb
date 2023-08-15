# frozen_string_literal: true

class ApplicationService
  def initialize(resource:, attributes:)
    @resource = resource
    @attributes = attributes
  end

  def self.fetch(resource:)
    new(resource:, attributes: {}).fetch
  end

  def fetch(&block)
    data = repository_class.retrieve

    return yield(@resource, data) if block

    presenter_class.new(resource: @resource).present(data: data)
  rescue
    @resource
  end

  alias_method :fetch!, :fetch

  private

  def repository_class
  end

  def presenter_class
  end
end
