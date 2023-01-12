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
        Loader.call(@config.load_paths)
      end

      def lookup
        Coactions[@config.base_class, @coactant].to_a.map(&:coactor)
      end

      class << self
        def callable?(coactant)
          coactant.is_a?(Symbol)
        end
      end
    end
  end
end
