# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class FieldsLabels < Fields

        def label_for(name)
          field = find(name)
          if field.nil?
            name.to_s.humanize
          else
            field.label
          end
        end

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
