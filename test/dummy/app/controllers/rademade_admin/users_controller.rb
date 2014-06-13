class RademadeAdmin::UsersController < RademadeAdmin::ModelController
  crud_options :list_fields => [:email, :first_name, :last_name, :status],
               :additional_form_fields => [:password],
               :model_name => 'User',
               :form_fields => [:email, :first_name, :last_name, :password, :status, :posts]
end