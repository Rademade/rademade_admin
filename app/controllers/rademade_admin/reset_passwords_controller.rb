# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ResetPasswordsController < RademadeAdmin::AbstractController

    layout 'login'

    helper RademadeAdmin::FormHelper
    helper RademadeAdmin::MenuHelper
    helper RademadeAdmin::UriHelper

    skip_before_action :require_login

    def show
      # params[:id] is JWT token
      # http://localhost:3000/reset_passwords/eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NDM4MTg4MTcsImlzcyI6IlJhZGVtYWRlIGFkbWluIHVzZXIiLCJpYXQiOiIyMDE4LTEyLTAzIDA4OjAzOjM3ICswMjAwIiwiYXVkIjoiYWRtaW4gdXNlciIsImVtYWlsIjoiaWtAcmFkZW1hZGUuY29tIn0.nP8Mj1k1TrlaO0eOqmNBvqILmSU8jWap3usBG9XUqLo
      @user = ResetPasswordToken.decode(params[:id])
    rescue
      redirect_to root_path
    end

    def update
      user = ResetPasswordToken.decode(params[:id])
      data = params.require(:data).permit(:password, :password_repeat).merge(user: user).to_hash.symbolize_keys

      RademadeAdmin::ResetPassword.call(data)

      render json: { redirect_to: login_url }
    rescue RademadeAdmin::FieldError => e
      render :json => { :errors => e.error_hash }, :status => :precondition_failed
    rescue JWT::DecodeError
      render json: { message: 'Error', with_return: true }, status: 404
    end
  end
end
