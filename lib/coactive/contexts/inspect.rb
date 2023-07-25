# frozen_string_literal: true

require_relative 'inspector'

module Coactive
  module Contexts
    module Inspect
      extend ActiveSupport::Concern

      def to_s
        "#<#{self.class} #{self.class.inspect(@_data)}>"
      end

      class_methods do
        def inspect(data)
          data.map { |k, v| "#{k}=#{Coactive::Contexts::Inspector.call(v)}" }.join(', ')
        end
      end
    end
  end
end
