class RademadeAdmin::UsersController < RademadeAdmin::ModelController
  crud_options :list_fields => [:email, :first_name, :last_name, :status],
               :additional_form_fields => [:password]

  def form_fields
    super - [:encrypted_password] + [:password]
  end
end