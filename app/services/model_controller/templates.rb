module RademadeAdmin
  module Templates

    def native_template_folder
      # 15 = "RademadeAdmin::".length
      # 11 = "Controller".length
      # e.g. RademadeAdmin::QuestionAnswer::UsersController to "question_answer/users"
      self.class.to_s[15..-11].underscore
    end

    def form_template_path(real = false)
      abstract_template (real ? '_' : '') + 'form'
    end

    def abstract_template(template)
      if template_exists?(template, "rademade_admin/#{native_template_folder}")
        "rademade_admin/#{native_template_folder}/#{template}"
      else
        "rademade_admin/abstract/#{template}"
      end
    end

  end
end