# -*- encoding : utf-8 -*-
class RademadeAdmin::PostsController < RademadeAdmin::ModelController

  options do
    list :headline
    form do
      headline
      text :text
      user
      tags
    end
  end

end
