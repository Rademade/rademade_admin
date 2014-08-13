# -*- encoding : utf-8 -*-
module RademadeAdmin
  class BooleanInput < SimpleForm::Inputs::BooleanInput

    def input
      "#{@builder.check_box(attribute_name, input_html_options)}".html_safe
    end

  end
end
