# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DashboardController < ::RademadeAdmin::ApplicationController

    helper RademadeAdmin::FormHelper
    helper RademadeAdmin::MenuHelper
    helper RademadeAdmin::UriHelper

    skip_before_action :require_login, :only => [:login]

    def index

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
