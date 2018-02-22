# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Templates

    def native_template_folder
      # e.g. RademadeAdmin::QuestionAnswer::UsersController to "rademade_admin/question_answer/users"
      @native_template_folder ||= self.class.to_s.gsub('Controller', '').underscore
    end

    def form_template_path(real = false)
      abstract_template((real ? '_' : '') + 'form')
    end

    def abstract_template(template)
      # TODO make with rails native controller extending
      if template_exists?(template, native_template_folder)
        "#{native_template_folder}/#{template}"
      else
        @template_service.template_path('abstract', template)
      end
    end

  end
end
