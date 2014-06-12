module RademadeAdmin

  class DashboardController < RademadeAdmin::AbstractController

    #skip_before_action :require_login, :only => [:login]

    def index

    end

    def login
      #redirect_to :action => 'index' if user_signed_in?
    end

  end
end
