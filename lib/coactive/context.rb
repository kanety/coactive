# frozen_string_literal: true

module Coactive
  class Context
    attr_reader :_data

    def initialize(data = {}, &block)
      data = data.to_h if data.respond_to?(:to_h)
      @_data = data
    end

    def [](key)
      @_data[key]
    end

    def []=(key, value)
      @_data[key] = value
    end

    def key?(key)
      @_data.key?(key)
    end

    def to_h
      @_data
    end

    def to_s
      attrs = @_data.map { |k, v| "#{k}=#{v.inspect}" }.join(', ')
      "#<#{self.class} #{attrs}>"
    end
    alias :inspect :to_s

    def define_accessors!(keys)
      Array(keys).each do |key|
        define_singleton_method key do
          @_data[key]
        end
        define_singleton_method "#{key}=" do |value|
          @_data[key] = value
        end
      end
    end
  end
end
