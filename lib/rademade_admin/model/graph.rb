# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Graph
      include Singleton

      DEFAULT_MODULE_NAME = 'RademadeAdmin'

      def add_pair(module_name, controller_name, inner)
        # Controller includes configuration for mapping model
        controller = controller_class(module_name, "#{controller_name}_controller")
        controller.configuration.model(controller_name.classify) unless controller.model_name
        model = controller.model_class
        @model_infos[model.to_s] ||= init_model_info({
          :model => model,
          :controller_name => controller_name,
          :module_name => module_name,
          :controller => controller,
          :inner => inner
        })
      end

      def model_info(model)
        model_name = model.to_s
        @model_infos[model_name] ||= init_model_info({
          :model => model,
          :controller => default_controller(model_name),
          :inner => false
        })
      end

      def root_models
        @root_models ||= @model_infos.select { |_, model_info| not model_info.nested? }.values
      end

      private

      def initialize
        @model_infos = {}
      end

      def init_model_info(options)
        model_reflection = RademadeAdmin::Model::Reflection.new(
          options[:model],
          options[:controller_name],
          options[:module_name]
        )
        RademadeAdmin::Model::Info.new(model_reflection, options[:controller].configuration, options[:inner])
      end

      def controller_class(module_name, full_controller_name)
        LoaderService.const_get("#{module_name}/#{full_controller_name}")
      rescue
        create_controller(full_controller_name, module_name)
      end

      def default_controller(model_name)
        controller = create_controller("#{model_name.pluralize}_controller")
        controller.configuration.model(model_name)
        controller
      end

      def create_controller(controller_name, module_name = nil)
        controller_module = module_name.nil? ? default_module : LoaderService.const_get(module_name)
        controller_module.const_set(controller_name.classify, Class.new(RademadeAdmin::ModelController))
      end

      def default_module
        LoaderService.const_get(DEFAULT_MODULE_NAME)
      rescue
        Object.const_set(DEFAULT_MODULE_NAME, Module.new)
      end

    end
  end
end