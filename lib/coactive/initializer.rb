# frozen_string_literal: true

require_relative 'context'
require_relative 'initializers/contexts'

module Coactive
  module Initializer
    extend ActiveSupport::Concern
    include Initializers::Contexts

    included do
      class_attribute :context_class
      self.context_class = Context
      attr_reader :context
    end

    def initialize(args = {}, &block)
      @context = self.class.context_class.new(args, &block)
      @context.define_accessors!(self.class._contexts.map(&:name))

      self.class._contexts.each do |var|
        if var.required? && !@context.key?(var.name)
          raise MissingContextError.new("missing required context: #{var.name}")
        end
        if var.default && !@context.key?(var.name)
          @context[var.name] = Initializer.resolve(self, var.default)
        end
      end
    end

    class << self
      def resolve(instance, value)
        if value.respond_to?(:call)
          instance.instance_exec(&value)
        elsif value.is_a?(Symbol) && instance.respond_to?(value, true)
          instance.send(value)
        else
          value.deep_dup
        end
      end
    end
  end
end
