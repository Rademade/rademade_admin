module RademadeAdmin
  module Templates

    def native_template_folder
      # 7 = "Admin::".length
      # 11 = "Controller".length
      # e.g. RademadeAdmin::QuestionAnswer::UsersController to "question_answer/users"
      self.class.to_s[7..-11].underscore
    end

    def template_folder
      #todo save in static variable
      template_exists?('_form', "rademade_admin/#{native_template_folder}") ? native_template_folder : 'abstract'
    end

    def form_template_path(real = false)
      "rademade_admin/#{template_folder}/" + (real ? '_' : '') + 'form'
    end

    def abstract_template(template)
      #todo if template doesn't exist in user application => render abstract template (form or view)
      "rademade_admin/abstract/#{template}"
      #unless template_exists?(template, "admin/#{native_template_folder}")
    end

  end
end