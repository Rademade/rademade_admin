# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class FieldsLabels < Fields

        protected
        def field_class
          RademadeAdmin::Model::Configuration::FieldLabel
        end

        def _init_from_options(*options)
          raise "Can't init labels from options"
        end

      end
    end
  end
end
