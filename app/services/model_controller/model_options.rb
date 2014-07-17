# -*- encoding : utf-8 -*-
module RademadeAdmin
  module ModelOptions

    def options(&options_block)
      configuration.instance_eval &options_block
    end

    def model_name
      configuration.model_name
    end

    def item_name
      configuration.item_name
    end

    def parent_menu_item
      configuration.parent_menu_item
    end

    def model_class
      configuration.model_class
    end

    def model_info
      @model_info ||= Model::Graph.instance.model_info(model_class)
    end

    def init_model_info(model_reflection)
      Model::Info.new(model_reflection, configuration)
    end

    private
    
    def configuration
      @configuration ||= Model::Configuration.new(controller_name)
    end

  end
end
