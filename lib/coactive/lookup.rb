# frozen_string_literal: true

require_relative 'lookups/base'
require_relative 'lookups/name'
require_relative 'lookups/object'

module Coactive
  class Lookup
    class << self
      class_attribute :lookups
      self.lookups = [Lookups::Name, Lookups::Object]

      class_attribute :cache
      self.cache = {}

      def call(klass, coactant)
        with_cache(klass, coactant) do
          lookup = lookups.detect { |lookup| lookup.callable?(coactant) }
          lookup.new(klass, coactant).call if lookup
        end
      end

      private

      def with_cache(klass, coactant)
        if klass.coactive_config.use_cache
          self.cache[klass] ||= {}
          self.cache[klass][coactant] ||= yield
        else
          yield
        end
      end
    end
  end
end
