# frozen_string_literal: true

module Coactive
  class Config
    DEFAULTS = {
      base_class: nil,
      load_paths: ['app/coactors'],
      class_suffix: 'Coactor',
      use_cache: true,
      lookup_superclass_for_object: true,
      lookup_superclass_until: ['ActiveRecord::Base', 'ActiveModel::Base'],
    }

    def initialize
      @data = DEFAULTS.deep_dup
    end

    DEFAULTS.keys.each do |key|
      define_method "#{key}" do
        @data[key]
      end

      define_method "#{key}=" do |val|
        @data[key] = val
      end
    end
  end
end
