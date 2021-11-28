# frozen_string_literal: true

module Coactive
  module Coaction
    extend ActiveSupport::Concern

    included do
      class_attribute :_coactions
      self._coactions = []
    end

    class_methods do
      def coaction(*coactions)
        self._coactions = _coactions + coactions
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
