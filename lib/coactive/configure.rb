# frozen_string_literal: true

require_relative 'config'

module Coactive
  module Configure
    extend ActiveSupport::Concern

    included do
      class_attribute :coactive_config
      self.coactive_config = Config.new
      self.coactive_config.base_class = self
    end

    class_methods do
      def configure_coactive
        self.coactive_config = Config.new(coactive_config.data)
        yield coactive_config
      end
    end
  end
end
