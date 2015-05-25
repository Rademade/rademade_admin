class RademadeAdmin::AuthorsController < RademadeAdmin::ModelController

  options do
    list :name, :articles, :verified
    form do
      name
      photo
      articles
      verified
      rubrics
    end
  end

end