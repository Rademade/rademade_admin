module RademadeAdmin
  module ModelConfiguration

    def options(&options_block)
      #todo extract config class
      # config.instance_eval &options_block
      instance_eval &options_block
    end

    def model_name
      if configuration[:model_name].nil?
        configuration[:model_name] = controller_name.classify
      end
      configuration[:model_name]
    end

    def item_name
      if configuration[:item_name].nil?
        configuration[:item_name] = model_name
      end
      configuration[:item_name]
    end

    def parent_menu_item
      configuration[:parent_menu_item]
    end

    def model_class
      if configuration[:model_class].nil?
        configuration[:model_class] = RademadeAdmin::LoaderService.const_get(model_name)
      end
      configuration[:model_class]
    end

    def model_info
      @model_info ||= Model::Graph.instance.model_info(model_class)
    end

    def init_model_info(model_reflection)
      Model::Info.new(model_reflection, configuration)
    end

    private
    
    def configuration
      @configuration ||= {}
    end

    def model(model_name)
      configuration[:model_name] = model_name
    end

    def item(item_name)
      configuration[:item_name] = item_name
    end

    def parent_menu(parent_menu_item)
      configuration[:parent_menu_item] = parent_menu_item
    end

    def list(*field_options, &block)
      configuration[:list_fields] = fields(*field_options, &block)
    end

    def form(*field_options, &block)
      configuration[:form_fields] = fields(*field_options, &block)
    end

    def fields(*field_options, &block)
      model_fields = block_given? ? Fields.init_from_block(&block) : Fields.init_from_options(field_options)
      model_fields.fields
    end

  end
end