class ApplicationCoactor
  include Coactive::Base

  configure_coactive do |config|
    config.load_paths = ['app/coactors']
    config.class_suffix = 'Coactor'
  end
end
