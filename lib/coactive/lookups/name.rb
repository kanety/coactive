# frozen_string_literal: true

module Coactive
  module Lookups
    class Name < Base
      def call
        load_files
        lookup
      end

      private

      def load_files
        Coactive::Loader.call(@klass.coactive_config.load_paths)
      end

      def lookup
        @klass.coactive_config.base_class.descendants.each_with_object({}).with_index do |(coactor, hash), i|
          coaction = coactor.coactions.detect { |coaction| coaction.name == @coactant }
          hash[[coaction.priority || 1 << 63, i]] = coactor if coaction
        end.sort.map { |x| x[1] }
      end

      class << self
        def callable?(coactant)
          coactant.is_a?(Symbol)
        end
      end
    end
  end
end
