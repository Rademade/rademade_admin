module RademadeAdmin
  class ApplicationController < ActionController::Base

    def current_ability
      @current_ability ||= RademadeAdmin::Ability.new(current_user)
    end

  end
end