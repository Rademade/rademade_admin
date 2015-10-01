# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Graph
      include Singleton

      def add_pair(module_name, controller_name, inner)
        # Controller includes configuration for mapping model
        controller = controller_class(module_name, "#{controller_name}_controller")
        controller.configuration.model(controller_name.classify) unless controller.model_name

        model = controller.model_class

        unless @model_infos[model.to_s]
          model_reflection = RademadeAdmin::Model::Reflection.new(model, controller_name, module_name)
          model_info = RademadeAdmin::Model::Info.new(model_reflection, controller.configuration, inner)
          @model_infos[model.to_s] = model_info
        end
      end

      def model_info(model)
        @model_infos[model.to_s]
      end

      def root_models
        @root_models ||= @model_infos.select { |_, model_info| not model_info.nested? }.values
      end

      private

      def initialize
        @model_infos = {}
      end

      def controller_class(module_name, full_controller_name)
        LoaderService.const_get("#{module_name}/#{full_controller_name}")
      rescue
        dynamic_controller = Class.new(RademadeAdmin::ModelController)
        LoaderService.const_get(module_name).const_set "#{full_controller_name}".classify, dynamic_controller
      end

    end
  end
end