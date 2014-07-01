class RademadeAdmin::PostsController < RademadeAdmin::ModelController
  crud_options :list_fields => [:headline],
               :model_name => 'Post',
               :form_fields => [:headline, :text, :user]
end