# frozen_string_literal: true

require_relative 'coaction'

module Coactive
  module Coactors
    module Coactions
      extend ActiveSupport::Concern

      included do
        class_attribute :coactions_map
        self.coactions_map = {}
      end

      class_methods do
        def coaction(*names, **options)
          names.each do |name|
            coactions = coactions_map[name].to_a + [Coaction.new(self, name, options)]
            coactions_map[name] = coactions.sort_by.with_index { |coaction, i| [coaction.priority, i] }
          end
        end
      end
    end
  end
end
