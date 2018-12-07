# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ForgotPasswordsController < RademadeAdmin::AbstractController

    layout 'login'

    skip_before_action :require_login

    def show
      if admin_logged_in?
        redirect_to root_path
      end
    end

    def create
      @user = RademadeAdmin.configuration.admin_class.get_by_email(params[:data][:email])

      if @user.nil?
        render json: { errors: { email: I18n.t('rademade_admin.forgot_password.validation.email') } }, status: :precondition_failed
      else
        token = ResetPasswordToken.encode(@user)
        UserMailer.reset_password(@user, token).deliver_now

        html_template = render_to_string('rademade_admin/forgot_passwords/success', layout: false)
        render json: { template: html_template }
      end

    end

  end
end
