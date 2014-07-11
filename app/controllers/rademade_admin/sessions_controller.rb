module RademadeAdmin
  class SessionsController < RademadeAdmin::AbstractController

    skip_before_action :require_login

    def create
      begin
        user = RademadeAdmin::Login.admin(params)
        sign_in user
        render :json => user, :status => :ok
      rescue RademadeAdmin::Login::Error => e
        render :json => {:errors => e.field_messages}, :status => :precondition_failed
      end
    end

    def logout
      sign_out current_user
      redirect_to :controller => 'dashboard', :action => 'login'
    end

  end
end
