# frozen_string_literal: true

module Coactive
  module Contextualizer
    extend ActiveSupport::Concern

    def contextualize
      self.class._contexts.each do |var|
        instance_variable_set("@#{var.name}", @context[var.name])
        define_singleton_method var.name do
          instance_variable_get("@#{var.name}")
        end
      end

      return_value = yield if block_given?

      self.class._contexts.each do |var|
        if var.output_return?
          @context[var.name] = return_value
        elsif var.output? && instance_variable_defined?("@#{var.name}")
          @context[var.name] = instance_variable_get("@#{var.name}")
        end
      end

      return_value
    end
  end
end
