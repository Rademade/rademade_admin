# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require 'mongoid'
require 'carrierwave/mount'
require 'carrierwave/mongoid'
require 'light_resizer'

Bundler.require(*Rails.groups)
require 'rademade_admin'

module Dummy
  class Application < Rails::Application

    require 'devise/orm/mongoid'
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.autoload_paths += Dir["#{Rails.root}/lib/**/"]

    config.middleware.insert_before(Rack::Sendfile, LightResizer::Middleware, Rails.root)

  end
end

