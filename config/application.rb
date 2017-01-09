require_relative "boot"

require "rails/all"
Bundler.require(*Rails.groups)

module EDocument01
  class Application < Rails::Application
  end
end
