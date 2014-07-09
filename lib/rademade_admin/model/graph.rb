module RademadeAdmin
  module Model
    class Graph
      include Singleton

      def add_pair(resource_name, controller_name, inner)
        controller_name ||= resource_name.to_s.tableize
        controller_full_name = ('rademade_admin/' + controller_name + '_controller')
        controller = controller_full_name.camelize.constantize
        model = controller.model_class
        unless @model_infos[model.to_s]
          model_reflection = Reflection.new(model, controller_name, controller_full_name, inner)
          @model_infos[model.to_s] = controller.init_model_info(model_reflection)
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