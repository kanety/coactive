# frozen_string_literal: true

require_relative 'variable'

module Coactive
  module Initializers
    module Contexts
      extend ActiveSupport::Concern

      included do
        class_attribute :_contexts
        self._contexts = []
      end

      class_methods do
        def context(*names, **options)
          self._contexts = _contexts.reject { |var| names.include?(var.name) }
          self._contexts += names.map { |name| Variable.new(name, options) }
        end
      end
    end
  end
end
