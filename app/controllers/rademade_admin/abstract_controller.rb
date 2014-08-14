# -*- encoding : utf-8 -*-
module RademadeAdmin
  class AbstractController < ApplicationController

    include ::RademadeAdmin::UriHelper
    include ::RademadeAdmin::Breadcrumbs

    layout 'rademade_admin'

    before_action :init_user, :require_login, :root_breadcrumbs

    rescue_from ::CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    protected

    def require_login
      redirect_to :controller => 'dashboard', :action => 'login' if @current_user.nil?
    end

    def init_user
      @current_user = RademadeAdmin.user_class.find(session[:user_id]) if session[:user_id].present?
    end

    def render_errors(errors)
      render :json => {
        :errors => errors,
        :message => 'Error occurred'
      }, :status => :unprocessable_entity
    end

  end
end
