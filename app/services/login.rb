# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Login

    def self.admin(params)
      params.require(:data).permit([:email, :password])
      user = RademadeAdmin.user_class.get_by_email(params[:data][:email])

      error(I18n.t('rademade_admin.login_email_not_found'), :email) unless user.is_a? RademadeAdmin.user_class
      error(I18n.t('rademade_admin.login_incorrect_password'), :password) unless user.valid_password? params[:data][:password]
      error(I18n.t('rademade_admin.login_access_denied'), :email) unless user.admin?

      user
    end

    def self.error(message, field)
      raise Error.new(message, field)
    end

  end
end
