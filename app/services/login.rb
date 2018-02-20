# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Login

    def self.admin(params)
      params.require(:data).permit([:email, :password])
      user = RademadeAdmin.configuration.admin_class.get_by_email(params[:data][:email])

      error(I18n.t('rademade_admin.login.validation.email_not_found'), :email) if user.nil?
      error(I18n.t('rademade_admin.login.validation.incorrect_password'), :password) unless user.valid_password? params[:data][:password]

      user
    end

    def self.error(message, field)
      raise Error.new(message, field)
    end

  end
end
