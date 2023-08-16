# frozen_string_literal: true

class ApplicationPresenter
  class_attribute :presenter_attributes, instance_writer: false
  class_attribute :presenter_methods, instance_writer: false

  class << self
    def attributes(*attributes_names)
      self.presenter_methods = attributes_names.extract_options!
      self.presenter_attributes = attributes_names.map(&:to_s)
    end
  end

  def initialize(resource:)
    @resource = resource
  end

  def present(data:)
    @original_data = data
    @data = mapper_data!(data)

    mapper_attributes!

    @resource
  end

  private

  def mapper_data!(data)
    data
  end

  def errors?
    @data.is_a?(Hash) && @data.key?("errors")
  end

  def mapper_attributes!
    return @resource if errors?

    @data.respond_to?(:with_indifferent_access) && (@data = @data.with_indifferent_access)

    presenter_attributes.each do |attribute|
      if @data.key?(attribute)
        @resource[attribute] = @data[attribute]
      elsif @data.respond_to?(attribute)
        @resource[attribute] = @data[attribute]
      elsif @data.key?(:metadata) && @data.fetch(:metadata, {}).key?(attribute)
        @resource[attribute] = @data[:metadata][attribute]
      end
    end

    presenter_methods.each do |attribute_method|
      attribute_name, method_name = attribute_method

      if @resource.respond_to?(attribute_name)
        if @resource.is_a?(ActiveRecord::Base)
          @resource[attribute_name] = send(method_name)
        else
          @resource.send("#{attribute_name}=", send(method_name))
        end
      else
        method_value = send(method_name)

        @resource.define_singleton_method(attribute_name) do
          method_value
        end
      end
    end
  end
end
