# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Graph
      include Singleton

      def add_pair(controller_name, inner)
        controller_full_name = ('rademade_admin/' + controller_name + '_controller')

        # Controller includes configuration for mapping model
        controller = controller_full_name.camelize.constantize
        model = controller.model_class

        unless @model_infos[model.to_s]
          model_reflection = RademadeAdmin::Model::Reflection.new(model, controller_name, controller_full_name, inner)
          @model_infos[model.to_s] = RademadeAdmin::Model::Info.new(model_reflection, controller.configuration)
        end
      end

      def model_info(model)
        @model_infos[model.to_s]
      end

      def root_models
        @root_models ||= get_root_models
      end

      private

      def initialize
        @model_infos = {}
      end

      def get_root_models
        @model_infos.select { |model_name, model_info| not model_info.nested? }.values
      end

    end
  end
end
