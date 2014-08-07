# -*- encoding : utf-8 -*-
require 'rademade_admin/model/configuration/fields'

module RademadeAdmin
  module Model
    class Configuration
      class FormFields < Fields

        protected
        def field_class
          RademadeAdmin::Model::Configuration::FormField
        end

      end
    end
  end
end
