class RademadeAdmin::PostsController < RademadeAdmin::ModelController

  options do
    model 'Post'
    parent_menu 'User'
    list :headline
    form :headline, :text, :user
  end

end