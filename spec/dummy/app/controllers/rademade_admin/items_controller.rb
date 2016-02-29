class RademadeAdmin::ItemsController < RademadeAdmin::ModelController

  options do
    list :name, :category
    form do
      name
      price
      category
      sequel_gallery
    end
  end

end