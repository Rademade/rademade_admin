module RademadeAdmin::MenuHelper

  def main_menu
    @model_infos = RademadeAdmin::Model::Graph.instance.root_models
    menu = collect_children
    menu.unshift({ :uri => url_for(:root), :name => 'Home', :ico => 'fa fa-home' })
    menu
  end

  private

  def collect_children(parent = nil)
    menu = []
    @model_infos.each do |model_info|
      if model_info.parent_menu_item == parent
        menu << { :model_info => model_info, :sub => collect_children(model_info.model.to_s) }
      end
    end
    menu
  end

end