# frozen_string_literal: true

module Coactive
  module Contexts
    module Inspect
      extend ActiveSupport::Concern

      def to_s
        "#<#{self.class} #{self.class.inspect(@_data)}>"
      end

      class_methods do
        def inspect(data)
          data.map { |k, v| "#{k}=#{Coactive::Contexts::Inspect.call(v)}" }.join(', ')
        end
      end

      class << self
        class_attribute :max_num, :max_length
        self.max_num = 5
        self.max_length = 300

        def call(data)
          if data.is_a?(Array)
            str = data.take(max_num).map { |v| call(v) }.join(', ')
            str += '...' if data.size > max_num
            "[#{str}]"
          elsif data.is_a?(Hash)
            str = data.take(max_num).map { |k, v| "#{k}: #{call(v)}" }.join(', ')
            str += '...' if data.size > max_num
            "{#{str}}"
          else
            data.to_s.truncate(max_length)
          end
        end
      end
    end
  end
end
