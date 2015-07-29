# -*- encoding : utf-8 -*-
module RademadeAdmin
  class AbstractController < ApplicationController

    include ::RademadeAdmin::UriHelper

    layout 'rademade_admin'

    before_action :init_user, :init_template_service, :require_login, :menu
    
    attr_reader :current_user

    rescue_from ::CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    protected

    def require_login
      redirect_to login_url unless admin_logged_in?
    end

    def init_user
      @current_user = RademadeAdmin.user_class.find(session[:user_id]) if session[:user_id].present?
    end

    def init_template_service
      @template_service = RademadeAdmin::TemplateService.new('rademade_admin')
    end

    def render_errors(errors)
      render :json => {
        :errors => errors,
        :message => 'Error occurred'
      }, :status => :unprocessable_entity
    end

    def admin_logged_in?
      @current_user.is_a? RademadeAdmin.user_class and @current_user.admin?
    end

    def current_ability
      @current_ability ||= (RademadeAdmin.ability_class || ::RademadeAdmin::Ability).new(@current_user)
    end

    def menu
      MenuCell.current_ability = current_ability
    end

  end
end
