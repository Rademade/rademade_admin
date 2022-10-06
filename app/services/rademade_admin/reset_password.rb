# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ResetPassword

    MIN_PASSWORD_LENGTH = 6

    def self.call(password:, password_repeat:, user:)
      error(I18n.t('rademade_admin.login.validation.password_length', length: MIN_PASSWORD_LENGTH), :password) if password.length < MIN_PASSWORD_LENGTH
      error(I18n.t('rademade_admin.login.validation.password_not_match'), :password_repeat) if password != password_repeat
      error(I18n.t('rademade_admin.login.validation.access_denied'), :password) unless user.admin?
      user.password = password
      user.save
    end

    def self.error(message, field)
      raise FieldError.new(field, message)
    end

  end
end
