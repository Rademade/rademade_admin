class RademadeAdmin::ArticlesController < RademadeAdmin::ModelController

  options do
    parent_menu 'Active record'
    list :name, :author
    menu_count { Article.count }
    form do
      name
      active_gallery
      publish_time
    end
  end

end