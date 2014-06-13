module RademadeAdmin
  class AdminUsersController < ModelController
    crud_options :list_fields => [:email, :first_name, :last_name],
                 :additional_form_fields => [:password],
                 :model_name => 'RademadeAdmin::AdminUser',
                 :form_fields => [:email, :first_name, :last_name, :password]
  end
end