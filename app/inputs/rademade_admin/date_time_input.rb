# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DateTimeInput < SimpleForm::Inputs::DateTimeInput

    def input(_)
      @builder.text_field(attribute_name, input_html_options.merge({
        :data => {
          :calendar_picker => 'datetime'
        },
        :value => object.send(attribute_name).try(:strftime, '%d.%m.%Y %R')
      }))
    end

    def additional_classes
      super + ['with-time']
    end

  end
end