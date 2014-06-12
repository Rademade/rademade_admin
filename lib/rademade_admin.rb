require 'rails/mongoid'

require 'devise'
require 'cancan'
require 'formtastic'

# js assets
require 'turbolinks'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'rails-backbone'
require 'select2-rails'
require 'jquery-fileupload-rails'
require 'magnific-popup-rails'

require 'ckeditor'

require 'rademade_admin/sortable'
module RademadeAdmin
  def self.user_class
    RademadeAdmin::AdminUser
  end
end

require "rademade_admin/engine"
