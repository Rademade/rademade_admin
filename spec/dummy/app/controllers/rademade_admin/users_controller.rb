# -*- encoding : utf-8 -*-
class RademadeAdmin::UsersController < RademadeAdmin::ModelController

  options do
    list :email, :first_name, :last_name, :avatar, :admin
    csv do
      full_name
      email
      admin :method => :admin_text
    end
    form do
      email :hint => 'Электронная почта'
      avatar
      first_name
      last_name
      address :'rademade_admin/location'
      posts
      admin :boolean
    end
    labels do
      full_name 'Полное имя'
      admin 'Права'
    end
  end

end
