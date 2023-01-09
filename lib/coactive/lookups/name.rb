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
        @klass.coactive_config.base_class.coactions_map[@coactant].to_a.map(&:coactor)
      end

      class << self
        def callable?(coactant)
          coactant.is_a?(Symbol)
        end
      end
    end
  end
end
