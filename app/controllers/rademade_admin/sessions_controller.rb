# -*- encoding : utf-8 -*-
module RademadeAdmin
  class SessionsController < RademadeAdmin::ApplicationController

    skip_before_action :require_login

    def login
      user = RademadeAdmin::Login.admin(params)
      session[:user_id] = user.id.to_s
      if session[:redirect_after].present?
        redirect_url = session[:redirect_after]
        session[:redirect_after] = nil
      else
        redirect_url = { :controller => 'dashboard', :action => 'index' }
      end
      respond_to do |format|
        format.html { redirect_to redirect_url }
        format.json { render :json => { redirect_url: redirect_url } }
      end
    rescue RademadeAdmin::Login::Error => e
      render :json => { :errors => e.field_messages }, :status => :precondition_failed
    end

    def logout
      session.delete(:user_id)
      redirect_to :controller => 'dashboard', :action => 'login'
    end

  end
end
