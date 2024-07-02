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
        source_path = caller_locations(1, 1).first.path
        names.each do |name|
          coaction = Coaction.new(self, name, source_path, Autoloader.reverse_index(source_path), options)
          coaction.priority ||= coactive_config.default_priority
          coactions = (Coactions[base, name].to_a + [coaction])
          Coactions[base, name] = coactions.sort_by.with_index { |coaction, i| [coaction.priority, coaction.path_index.to_i, i] }
        end
      end
    end
  end
end
