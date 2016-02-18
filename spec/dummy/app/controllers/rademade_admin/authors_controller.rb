class RademadeAdmin::AuthorsController < RademadeAdmin::ModelController

  options do
    parent_menu 'Active record'
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