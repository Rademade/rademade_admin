# -*- encoding : utf-8 -*-
class RademadeAdmin::TagsController < RademadeAdmin::ModelController

  options do
    model 'Tag'
    parent_menu 'Post'
  end

end
