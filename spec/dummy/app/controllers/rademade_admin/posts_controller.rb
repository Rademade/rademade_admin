# -*- encoding : utf-8 -*-
class RademadeAdmin::PostsController < RademadeAdmin::ModelController

  options do
    list :headline
    form do
      headline
      avatar
      video
      text :text
      user
      tags
      document
      status :as => :select,
             :collection => {
                 'Новый'    => '1',
                 'Отклонен' => '2'
             },
             :include_blank => false
    end
    labels do
      headline 'Post name'
    end
  end

end
