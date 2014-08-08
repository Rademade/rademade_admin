# -*- encoding : utf-8 -*-
require 'kaminari'
require 'carrierwave'
require 'breadcrumbs'

require 'cancan'
require 'bower-rails'
require 'compass-rails'

# js assets
require 'turbolinks'

require 'formtastic'
require 'ckeditor'

require 'rademade_admin/sortable'
require 'rademade_admin/engine'

module RademadeAdmin

  def self.user_class
    RademadeAdmin::Configuration.user_class
  end

end
