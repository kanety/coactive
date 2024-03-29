# frozen_string_literal: true

module Coactive
  module Railtie
    ActiveSupport::Reloader.to_prepare do
      Coactive::Loader.loaded.clear
      Coactive::Lookup.cache.clear
      Coactive::Coactions.registry.clear
    end
  end
end
