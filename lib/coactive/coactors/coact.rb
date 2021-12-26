# frozen_string_literal: true

module Coactive
  module Coactors
    module Coact
      extend ActiveSupport::Concern

      included do
        class_attribute :_coactants
        self._coactants = []
      end

      class_methods do
        def coact(*coactants, **options, &block)
          if block
            self._coactants = _coactants + [block]
          elsif options[:before]
            index = self._coactants.index { |coactant| coactant == options[:before] }
            self._coactants = self._coactants.insert(index, *coactants)
          else
            self._coactants = _coactants + coactants
          end
        end

        def coactants
          self._coactants
        end

        def clear_coactants
          self._coactants = []
        end
      end
    end
  end
end
