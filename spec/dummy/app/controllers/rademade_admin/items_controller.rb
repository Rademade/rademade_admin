class RademadeAdmin::ItemsController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
      price
      category
    end
  end

end