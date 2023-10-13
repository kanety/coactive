Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
end

if Rails::VERSION::STRING.to_f == 6.0
  Rails.autoloaders.main.enable_reloading
end
