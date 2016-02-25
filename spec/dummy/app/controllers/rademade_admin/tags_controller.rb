# -*- encoding : utf-8 -*-
class RademadeAdmin::TagsController < RademadeAdmin::ModelController

  options do
    parent_menu 'Post'
    list :name
    form do
      name
      description :text
    end
    filter do
      name
    end
  end

end