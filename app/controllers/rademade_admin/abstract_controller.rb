module RademadeAdmin
  class AbstractController < ApplicationController
    include ::RademadeAdmin::UriHelper

    layout 'rademade_admin'

    before_action :require_login

    rescue_from ::CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    def require_login
      redirect_to :controller => 'dashboard', :action => 'login' unless user_signed_in?
    end

    def render_errors(errors)
      render :json => {
        :errors => errors,
        :message => 'Error occurred'
      }, :status => :unprocessable_entity
    end
  end
end
