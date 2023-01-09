# frozen_string_literal: true

module Coactive
  module Lookups
    class Base
      def initialize(klass, coactant)
        @klass = klass
        @coactant = coactant
        @config = @klass.coactive_config
      end

      def call
      end

      class << self
        def callable?(coactant)
        end
      end
    end
  end
end
