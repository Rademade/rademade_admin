class RademadeAdmin::CategoriesController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
    end
  end

end