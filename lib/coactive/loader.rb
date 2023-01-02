# frozen_string_literal: true

module Coactive
  module Loader
    class << self
      class_attribute :loaded
      self.loaded = {}

      def call(paths)
        return unless defined?(Rails)
        return if Rails.application.config.eager_load || paths.blank?

        Array.wrap(paths).each do |path|
          unless loaded[path]
            load(path)
            loaded[path] = true
          end
        end
      end

      private

      def load(path)
        rails_engines.each do |engine|
          Dir["#{engine.root}/#{path}/**/*.rb"].each do |file|
            require_dependency file
          end
        end
      end

      def rails_engines
        [Rails] + Rails::Engine.subclasses.map(&:instance)
      end
    end
  end
end
