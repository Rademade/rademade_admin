class RademadeAdmin::ArticlesController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
      publish_time
    end
  end

end