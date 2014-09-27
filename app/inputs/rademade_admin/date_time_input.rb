# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DateTimeInput < SimpleForm::Inputs::DateTimeInput

    def input
      @builder.text_field(attribute_name, input_html_options.merge({
        :data => { 'date-time-picker' => '' },
        :value => object.send(attribute_name).try(:strftime, '%d.%m.%Y %R')
      }))
    end

  end
end