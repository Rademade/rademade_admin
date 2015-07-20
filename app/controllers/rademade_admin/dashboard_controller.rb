# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DashboardController < RademadeAdmin::AbstractController

    skip_before_action :require_login, :only => [:login]

    def index
      MenuCell.current_model = nil
    end

    def login
      if admin_logged_in?
        redirect_to :action => 'index'
      else
        render :layout => 'login'
      end
    end

  end
end
