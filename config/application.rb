require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "sprockets/railtie"

Bundler.require(*Rails.groups)

module MlsChat
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
      g.request_specs true
      g.routing_specs true
      g.controller_specs false
    end
  end
end
