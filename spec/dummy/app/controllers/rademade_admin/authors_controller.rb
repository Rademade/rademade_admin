class RademadeAdmin::AuthorsController < RademadeAdmin::ModelController

  options do
    list :name
    form do
      name
      photo
      articles
      verified :boolean
    end
  end

end