# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require 'mongoid'

require 'devise'

Bundler.require(*Rails.groups)
require 'rademade_admin'

module Dummy
  class Application < Rails::Application

    require 'devise/orm/mongoid'

    config.autoload_paths += Dir["#{Rails.root}/lib/**/"]

  end
end

