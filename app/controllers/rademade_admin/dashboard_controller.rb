# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DashboardController < RademadeAdmin::AbstractController

    skip_before_action :require_login, :only => [:login]

    def index

    end

    def login
      redirect_to :action => 'index' unless @current_user.nil?
    end

  end
end
