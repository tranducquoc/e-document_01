require_relative "boot"

require "rails/all"
Bundler.require(*Rails.groups)

module EDocument01
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.active_record.raise_in_transactional_callbacks = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.time_zone = "Hanoi"
  end
end
