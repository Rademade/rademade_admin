# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class ListFields < Fields

        protected

        def field_class
          RademadeAdmin::Model::Configuration::ListField
        end

      end
    end
  end
end
