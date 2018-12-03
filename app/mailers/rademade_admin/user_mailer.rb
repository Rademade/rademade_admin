module RademadeAdmin

  class UserMailer < RademadeAdmin::ApplicationMailer

    def reset_password(user, token)
      @token = token
      @user = user

      mail(to: user.email, subject: 'Rademade Admin reset password instructions')
    end

  end

end
