require 'kaminari'
require 'carrierwave'

require 'devise'
require 'cancan'

require 'bower-rails'

# js assets
require 'turbolinks'
require 'jquery-fileupload-rails'
require 'magnific-popup-rails'

require 'formtastic'
require 'ckeditor'

require 'rademade_admin/sortable'
require 'rademade_admin/engine'

module RademadeAdmin

  def self.user_class
    RademadeAdmin::Configuration.user_class
  end

end
