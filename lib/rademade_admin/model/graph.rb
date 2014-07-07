module RademadeAdmin
  module Model
    class Graph
      include Singleton

      def add_pair(resource_name, controller, inner)
        controller ||= resource_name.to_s.tableize
        #todo folder of admin controllers
        controller_name = ('rademade_admin/' + controller + '_controller')
        model = controller_name.camelize.constantize.model_class
        @model_reflections[model.to_s] ||= Reflection.new(model, controller, controller_name, inner)
      end

      def model_reflection(model)
        @model_reflections[model.to_s]
      end

      def root_models
        @root_models ||= get_root_models
      end

      private

      def initialize
        @model_reflections = {}
      end

      def get_root_models
        @model_reflections.select { |model_name, model_reflection| !model_reflection.nested? }.values
      end

    end
  end
end