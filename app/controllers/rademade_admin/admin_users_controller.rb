# -*- encoding : utf-8 -*-
module RademadeAdmin
  class AdminUsersController < ModelController

    options do
      model 'RademadeAdmin::AdminUser'
      list :email, :first_name, :last_name
      form do
        email
        first_name
        last_name
        password
      end
    end

  end
end
