module RademadeAdmin
  module ModelConfiguration

    def options(&options_block)
      instance_eval &options_block
    end

    def method_missing(name, *arguments)
      instance_variable_set("@#{name.to_s}_name", *arguments) # todo
    end

    private

    def list(*field_options, &block)
      @list_fields = fields(*field_options, &block)
    end

    def form(*field_options, &block)
      @form_fields = fields(*field_options, &block)
    end

    def fields(*field_options, &block)
      model_fields = block_given? ? Fields.init_from_block(&block) : Fields.init_from_options(field_options)
      model_fields.fields
    end

  end
end