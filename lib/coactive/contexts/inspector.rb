# frozen_string_literal: true

module Coactive
  module Contexts
    module Inspector
      class << self
        class_attribute :max_num, :max_length, :basic_classes
        self.max_num = 3
        self.max_length = 100
        self.basic_classes = [Module, Symbol, String, Numeric, TrueClass, FalseClass, NilClass, Regexp]

        def call(data)
          if data.is_a?(Array)
            inspect_array(data)
          elsif data.is_a?(Hash)
            inspect_hash(data)
          elsif basic_classes.any? { |klass| data.is_a?(klass) }
            inspect_basic(data)
          else
            inspect_object(data)
          end
        end

        private

        def inspect_array(data)
          str = data.take(max_num).map { |v| call(v) }.join(', ')
          str += "..." if data.size > max_num
          "[#{str}]"
        end

        def inspect_hash(data)
          str = data.take(max_num).map { |k, v| "#{k}: #{call(v)}" }.join(', ')
          str += "..." if data.size > max_num
          "{#{str}}"
        end

        def inspect_basic(data)
          data.inspect
        end

        def inspect_object(data)
          "#<#{data.class}:#{data.object_id}>"
        end
      end
    end
  end
end
