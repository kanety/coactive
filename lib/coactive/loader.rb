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
        autoload_paths.each do |autoload_path|
          if autoload_path.end_with?("/#{path}")
            if Rails.respond_to?(:autoloaders)
              Rails.autoloaders.main.eager_load_dir(autoload_path)
            else
              eager_load_dir(autoload_path)
            end
          end
        end
      end

      def eager_load_dir(autoload_path)
        Dir["#{autoload_path}/**/*.rb"].each do |file|
          require_dependency(file)
        end
      end

      def autoload_paths
        ActiveSupport::Dependencies.autoload_paths
      end
    end
  end
end
