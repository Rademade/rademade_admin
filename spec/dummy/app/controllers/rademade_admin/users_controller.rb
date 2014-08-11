# -*- encoding : utf-8 -*-
class RademadeAdmin::UsersController < RademadeAdmin::ModelController

  options do
    model 'User'
    list :email, :first_name, :last_name
    form do
      email
      avatar :'rademade_admin/admin_file'
      first_name
      last_name
      password
      posts
    end
  end

end
