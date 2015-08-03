# -*- encoding : utf-8 -*-
module RademadeAdmin
  class BooleanInput < SimpleForm::Inputs::Base

    def input(wrapper_options = {})
      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
      template.content_tag(:span, checkbox_html(merged_input_options), :class => 'form-checkbox')
    end

    private

    def checkbox_html(input_options)
      @builder.check_box(attribute_name, input_options, checked_value, unchecked_value)
    end

    def checked_value
      options.fetch(:checked_value, '1')
    end

    def unchecked_value
      options.fetch(:unchecked_value, '0')
    end

  end
end