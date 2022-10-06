# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Ability
    include CanCan::Ability

    def initialize(user)
      if user.try(:admin?)
        can :manage, :all
      end
    end

  end
end
