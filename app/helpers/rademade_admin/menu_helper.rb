module RademadeAdmin::MenuHelper
  def main_menu

    menu = [{ :uri => url_for([:admin, :root]), :name => 'Home', :ico => 'fa fa-home' }]

    ModelGraph.instance.root_models.each do |model_info|
      parent = model_info.parent_menu_item
      if parent.nil?
        menu = append_menu_item(menu, model_info.model)
      else
        menu = append_menu_item(menu, parent.constantize)
        menu.select { |x| x[:model] == parent.constantize }.first[:sub] << model_info.model
      end
    end

    menu
  end

  private

  def append_menu_item(menu, model)
    index = menu.index { |x| x[:model] == model }
    menu << { :model => model, :sub => [] } unless  index
    menu
  end

end