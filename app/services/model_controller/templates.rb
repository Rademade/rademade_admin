# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Templates

    def native_template_folder
      # 15 = "RademadeAdmin::".length
      # 11 = "Controller".length
      # e.g. RademadeAdmin::QuestionAnswer::UsersController to "question_answer/users"
      @native_template_folder ||= self.class.to_s[15..-11].underscore
    end

    def form_template_path(real = false)
      abstract_template((real ? '_' : '') + 'form')
    end

    def abstract_template(template)
      if template_exists?(template, @template_service.template_path(native_template_folder))
        folder = native_template_folder
      else
        folder = 'abstract'
      end
      @template_service.template_path(folder, template)
    end

  end
end
