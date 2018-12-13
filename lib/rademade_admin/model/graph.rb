# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Graph
      include Singleton

      DEFAULT_MODULE_NAME = 'RademadeAdmin'

      attr_reader :model_infos

      def add_pair(module_name, controller_name)
        # Controller includes configuration for mapping model
        controller = controller_class(module_name, "#{controller_name}_controller")
        controller.configuration.model(controller_name.classify) unless controller.model_name
        model = controller.model_class
        @model_infos[model.to_s] ||= init_model_info({
          :model => model,
          :controller_name => controller_name,
          :module_name => module_name,
          :controller => controller
        })
      end

      def add_pair_lazy(module_name, controller_name)
        @pairs << { module_name: module_name, controller_name: controller_name }
      end

      def init_pairs
        while pair = @pairs.shift
          add_pair(pair[:module_name], pair[:controller_name])
        end
      end

      def model_info(model)
        model_name = model.to_s
        @model_infos[model_name] ||= init_model_info({
          :model => model,
          :controller => default_controller(model_name)
        })
      end

      private

      def initialize
        @model_infos = {}
        @pairs = []
      end

      def init_model_info(model: nil, controller_name: nil, module_name: nil, controller: nil)
        model_reflection = RademadeAdmin::Model::Reflection.new(model, controller_name, module_name)
        RademadeAdmin::Model::Info.new(model_reflection, controller.configuration)
      end

      def controller_class(module_name, full_controller_name)
        LoaderService.const_get("#{module_name}/#{full_controller_name}")
      rescue
        Logger.new(STDOUT).info "Failed to load: #{module_name}/#{full_controller_name}"
        create_controller(full_controller_name, module_name)
      end

      def default_controller(model_name)
        controller = create_controller("#{model_name.pluralize}_controller")
        controller.configuration.model(model_name)
        controller
      end

      def create_controller(controller_name, module_name = nil)
        controller_module = module_name.nil? ? default_module : LoaderService.const_get(module_name)
        controller = controller_module.const_set(controller_name.classify, Class.new(RademadeAdmin::ModelController))
        Logger.new(STDOUT).info "RademadeAdmin initialized #{controller}"
        controller
      end

      def default_module
        LoaderService.const_get(DEFAULT_MODULE_NAME)
      rescue
        Object.const_set(DEFAULT_MODULE_NAME, Module.new)
      end

    end
  end
end
