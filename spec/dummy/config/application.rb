require_relative 'boot'

require 'action_controller/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "coactive"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f if config.respond_to?(:load_defaults)
  end
end
