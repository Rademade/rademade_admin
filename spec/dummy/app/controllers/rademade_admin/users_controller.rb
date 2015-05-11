# -*- encoding : utf-8 -*-
class RademadeAdmin::UsersController < RademadeAdmin::ModelController

  options do
    list :email, :first_name, :last_name, :avatar
    form do
      email :hint => 'Электронная почта'
      avatar
      first_name
      last_name
      address :'rademade_admin/location'
      posts
      admin :boolean
    end
  end

end
