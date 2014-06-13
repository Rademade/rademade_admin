module RademadeAdmin::MenuHelper
  def main_menu
    menu = [{ :uri => url_for(:root), :name => 'Home', :ico => 'fa fa-home' }]

    ModelGraph.instance.root_models.each do |model_info|
      parent = model_info.parent_menu_item
      if parent.nil?
        menu = append_menu_item(menu, model_info.model)
      else
        menu = append_menu_item(menu, parent.constantize)
        menu.select { |x| x[:model].to_s == parent }.first[:sub] << model_info.model
      end
    end

    menu
  end

  private

  def append_menu_item(menu, model)
    not_exist = menu.select { |x| x[:model].to_s == model.to_s }.empty?

    menu << { :model => model, :sub => [] } if not_exist
    menu
  end

end