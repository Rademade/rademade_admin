# -*- encoding : utf-8 -*-
module RademadeAdmin
  module ModelOptions

    # Configure admin part of model
    # Support options
    #  - model
    #  - name
    #  - parent_menu (todo extract to menu method)
    #  - menu_count
    #  - list
    #  - form
    #  - labels
    #
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

    def configuration
      @configuration ||= Model::Configuration.new(self)
    end

  end
end
