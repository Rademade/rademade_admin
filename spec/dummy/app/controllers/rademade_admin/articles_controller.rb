class RademadeAdmin::ArticlesController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
    end
  end

end