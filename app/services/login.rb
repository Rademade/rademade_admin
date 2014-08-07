# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Login

    def self.admin(params)
      params.require(:data).permit([:email, :password])
      user = RademadeAdmin.user_class.get_by_email(params[:data][:email])

      error('There is no users with such email', :email) unless user.is_a? RademadeAdmin.user_class
      error('Incorrect password', :password) unless user.valid_password? params[:data][:password]
      error('Access denied', :email) unless user.admin?

      user
    end

    def self.error(message, field)
      raise Error.new(message, field)
    end

  end
end
