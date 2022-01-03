# frozen_string_literal: true

module Coactive
  module Initializers
    class Variable < Struct.new(:name, :options)
      def default
        options[:default] if options
      end

      def required?
        options[:required] if options
      end

      def output?
        options[:output] if options
      end

      def output_return?
        options[:output] == :return if options
      end
    end
  end
end
