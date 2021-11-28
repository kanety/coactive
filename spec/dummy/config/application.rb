require_relative 'boot'

require 'action_controller/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "coactive"

module Dummy
  class Application < Rails::Application
  end
end
