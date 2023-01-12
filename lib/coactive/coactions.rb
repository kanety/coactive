# frozen_string_literal: true

require_relative 'coaction'

module Coactive
  module Coactions
    extend ActiveSupport::Concern

    class << self
      class_attribute :registry
      self.registry = {}

      def [](base, name)
        registry.dig(base, name)
      end

      def []=(base, name, array)
        registry[base] ||= {}
        registry[base][name] = array
      end
    end

    class_methods do
      def coaction(*names, **options)
        base = coactive_config.base_class
        names.each do |name|
          coactions = Coactions[base, name].to_a + [Coaction.new(self, name, options)]
          Coactions[base, name] = coactions.sort_by.with_index { |coaction, i| [coaction.priority, i] }
        end
      end
    end
  end
end
