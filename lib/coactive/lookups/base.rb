# frozen_string_literal: true

module Coactive
  module Lookups
    class Base
      def initialize(klass, coactant)
        @klass = klass
        @coactant = coactant
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
