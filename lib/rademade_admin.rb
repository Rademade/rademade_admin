require 'kaminari'
require 'carrierwave'

require 'devise'
require 'cancan'

# js assets
require 'turbolinks'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'rails-backbone'
require 'select2-rails'
require 'jquery-fileupload-rails'
require 'magnific-popup-rails'

require 'formtastic'
require 'ckeditor'

require 'rademade_admin/sortable'
require 'rademade_admin/engine'

module RademadeAdmin
  def self.user_class
    RademadeAdmin::Configuration.user_class || RademadeAdmin::User # todo default working user class
  end
end
