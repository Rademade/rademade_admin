# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DateInput < SimpleForm::Inputs::DateTimeInput

    def input(_)
      @builder.text_field(attribute_name, input_html_options.merge({
        :data => {
          :calendar_picker => 'date'
        },
        :value => object.try(attribute_name).try(:strftime, '%d.%m.%Y')
      }))
    end

  end
end