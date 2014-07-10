class RademadeAdmin::UsersController < RademadeAdmin::ModelController

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