# -*- encoding : utf-8 -*-
class RademadeAdmin::UsersController < RademadeAdmin::ModelController

  options do
    list :email, :first_name, :last_name
    form do
      email
      #avatar
      first_name
      last_name
      password
      #posts
      admin :'rademade_admin/boolean'
    end
  end

end
