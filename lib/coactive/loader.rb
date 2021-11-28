# frozen_string_literal: true

module Coactive
  module Loader
    class << self
      def call(paths)
        return unless defined?(Rails)
        return if Rails.application.config.eager_load
        return if paths.blank?

        engines = [Rails] + Rails::Engine.subclasses.map(&:instance)
        engines.each do |engine|
          Dir["#{engine.root}/{#{Array(paths).join(',')}}/**/*.rb"].each do |file|
            require file
          end
        end
      end
    end
  end
end
