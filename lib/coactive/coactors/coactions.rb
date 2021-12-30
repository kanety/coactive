# frozen_string_literal: true

require_relative 'coaction'

module Coactive
  module Coactors
    module Coactions
      extend ActiveSupport::Concern

      included do
        class_attribute :_coactions
        self._coactions = []
      end

      class_methods do
        def coaction(*names, **options)
          self._coactions = _coactions + names.map { |name| Coaction.new(name, options) }
        end

        def coactions
          self._coactions
        end

        def clear_coactions
          self._coactions = []
        end
      end
    end
  end
end
