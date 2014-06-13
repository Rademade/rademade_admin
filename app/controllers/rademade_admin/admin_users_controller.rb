module RademadeAdmin
  class AdminUsersController < ModelController
    crud_options :list_fields => [:email, :first_name, :last_name],
                 :additional_form_fields => [:password],
                 :model_name => 'RademadeAdmin::AdminUser'

    def form_fields
      super - [:encrypted_password] + [:password]
    end
  end
end