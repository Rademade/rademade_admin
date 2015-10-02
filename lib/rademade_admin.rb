# -*- encoding : utf-8 -*-
require 'kaminari'
require 'cancan'
require 'bower-rails'
require 'autoprefixer-rails'
require 'sass-rails'
require 'configurations'

# js assets
require 'turbolinks'
require 'i18n-js'
require 'simple_form'
require 'ckeditor'

require 'rademade_admin/sortable'
require 'rademade_admin/engine'

require 'mongoid_sortable_relation'

module RademadeAdmin

  include Configurations

  configurable :admin_class, :ability_class

  configuration_defaults do |default_config|
    default_config.ability_class = ::RademadeAdmin::Ability
  end

end