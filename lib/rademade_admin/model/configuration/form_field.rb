# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class FormField

        attr_accessor :name, :params

        def initialize(name, params = {})
          @name = name
          init_params(params)
        end

        private

        def init_params(params)
          if params.is_a? Hash
            @params = params
          else
            @params = { :as => params }
          end
        end

      end
    end
  end
end