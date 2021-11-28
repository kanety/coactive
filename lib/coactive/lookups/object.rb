# frozen_string_literal: true

module Coactive
  module Lookups
    class Object < Base
      def call
        lookup(@coactant)
      end

      private

      def lookup(coactant)
        return if terminate?(coactant)

        if coactant.name.present? && (coactor = resolve(coactant))
          coactor
        elsif @klass.coactive_config.lookup_superclass_for_object && coactant.superclass
          lookup(coactant.superclass)
        end
      end

      def terminate?(coactant)
        coactant.name.to_s.in?(@klass.coactive_config.lookup_superclass_until)
      end

      def resolve(coactant)
        name = resolve_name(coactant)
        coactor = name.safe_constantize
        return coactor if coactor && name == coactor.name
      end

      def resolve_name(coactant)
        suffix = @klass.coactive_config.class_suffix
        namespace = @klass.name.to_s.sub(/#{suffix}$/, '').to_s
        [namespace, "#{coactant.name}#{suffix}"].join('::')
      end

      class << self
        def callable?(coactant)
          coactant.is_a?(Module)
        end
      end
    end
  end
end
