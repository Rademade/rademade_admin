class RademadeAdmin::ArticlesController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
      active_gallery
      publish_time
    end
  end

end