# frozen_string_literal: true

require_relative 'loader'
require_relative 'lookup'
require_relative 'coactors/coact'
require_relative 'coactors/coaction'

module Coactive
  module Coactor
    extend ActiveSupport::Concern
    include Coactors::Coact
    include Coactors::Coaction

    def coactors
      self.class._coactants.map do |coactant|
        if coactant.is_a?(Symbol) && respond_to?(coactant, true)
          send(coactant)
        elsif coactant.is_a?(Proc)
          instance_exec(&coactant)
        else
          coactant
        end
      end.flatten.compact.map do |coactant|
        if coactant.is_a?(Class) && coactant < self.class.coactive_config.base_class
          coactant
        else
          self.class.coactors(coactant)
        end
      end.flatten.compact
    end

    class_methods do
      def coactors(*coactants)
        coactants = _coactants unless coactants
        coactants.map { |coactant| Lookup.call(self, coactant) }.flatten
      end
    end
  end
end
