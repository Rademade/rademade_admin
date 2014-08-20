# -*- encoding : utf-8 -*-
class RademadeAdmin::TagsController < RademadeAdmin::ModelController

  options do
    parent_menu 'Post'
    list :name
    form :name
  end

end
