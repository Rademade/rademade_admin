# -*- encoding : utf-8 -*-
module RademadeAdmin
  class SessionsController < RademadeAdmin::AbstractController

    skip_before_action :require_login

    def login
      user = RademadeAdmin::Login.admin(params)
      session[:user_id] = user.id.to_s
      respond_to do |format|
        format.html { redirect_to :controller => 'dashboard', :action => 'index' }
        format.json { render :json => user }
      end
    rescue RademadeAdmin::Login::Error => e
      render :json => { :errors => e.field_messages }, :status => :precondition_failed
    end

    def destroy
      session.delete(:user_id)
      redirect_to :controller => 'dashboard', :action => 'login'
    end

  end
end
