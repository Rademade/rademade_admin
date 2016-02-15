# -*- encoding : utf-8 -*-
class RademadeAdmin::RubricsController < RademadeAdmin::ModelController

  options do
    parent_menu 'Active record'
    list :name
    form :name
  end

end
