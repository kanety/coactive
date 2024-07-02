# frozen_string_literal: true

module Coactive
  class Autoloader
    class << self
      class_attribute :loaded
      self.loaded = {}

      def autoload_paths
        ActiveSupport::Dependencies.autoload_paths
      end

      def reverse_autoload_paths
        return @reverse_autoload_paths if defined?(@reverse_autoload_paths)

        @reverse_autoload_paths ||=
          if defined?(Rails)
            app_paths, lib_paths = autoload_paths.partition { |autoload_path| autoload_path.start_with?("#{Rails.root}/") }
            app_paths + lib_paths.reverse
          else
            autoload_paths.reverse
          end
      end

      def reverse_index(path)
        reverse_autoload_paths.index { |autoload_path| path.start_with?("#{autoload_path}/") }
      end

      def load(paths)
        return unless defined?(Rails)
        return if Rails.application.config.eager_load || paths.blank?

        Array.wrap(paths).each do |path|
          unless loaded[path]
            load_path(path)
            loaded[path] = true
          end
        end
      end

      private

      def load_path(path)
        autoload_paths.each do |autoload_path|
          if autoload_path.end_with?("/#{path}")
            if Rails.respond_to?(:autoloaders)
              Rails.autoloaders.main.eager_load_dir(autoload_path)
            else
              eager_load_path(autoload_path)
            end
          end
        end
      end

      def eager_load_path(autoload_path)
        Dir["#{autoload_path}/**/*.rb"].each do |file|
          require_dependency file
        end
      end
    end
  end
end
