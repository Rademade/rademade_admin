# -*- encoding : utf-8 -*-
module RademadeAdmin
  module InstanceOptions

    attr_reader :model_info, :model_class, :model_name, :item_name,
                :list_fields, :simple_form_fields, :localizable_form_fields

    def load_model_options
      @model_info = self.class.model_info
      @model_name = self.class.model_name
      @model_class = self.class.model_class
      @item_name = self.class.item_name
    end

    def load_field_options
      @list_fields = @model_info.data_items.list_fields
      @simple_form_fields = @model_info.data_items.simple_form_fields
      @localizable_form_fields = @model_info.data_items.localizable_form_fields
    end

    def origin_fields
      @model_info.data_items.origin_fields
    end

    def filter_fields
      @model_info.data_items.filter_fields
    end

    def load_template_options
      @form_template_path ||= form_template_path
    end

    def load_options
      load_model_options
      load_field_options
      load_template_options
    end

  end
end
