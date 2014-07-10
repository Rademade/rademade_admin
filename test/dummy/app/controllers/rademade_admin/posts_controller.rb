class RademadeAdmin::PostsController < RademadeAdmin::ModelController

  options do
    model 'Post'
    list :headline
    form :headline, :text, :user
  end

end