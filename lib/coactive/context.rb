# frozen_string_literal: true

require_relative 'contexts/inspect'

module Coactive
  class Context
    include Contexts::Inspect

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
