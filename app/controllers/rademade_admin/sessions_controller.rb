# -*- encoding : utf-8 -*-
module RademadeAdmin
  class SessionsController < RademadeAdmin::AbstractController

    skip_before_action :require_login

    def login
      begin
        user = RademadeAdmin::Login.admin(params)
        session[:user_id] = user.id.to_s
        render :json => user, :status => :ok
      rescue RademadeAdmin::Login::Error => e
        render :json => {:errors => e.field_messages}, :status => :precondition_failed
      end
    end

    def logout
      session.delete(:user_id)
      redirect_to :controller => 'dashboard', :action => 'login'
    end

  end
end
