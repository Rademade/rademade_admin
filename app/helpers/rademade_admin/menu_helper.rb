module RademadeAdmin::MenuHelper

  def main_menu
    @models = RademadeAdmin::Model::Graph.instance.root_models
    menu = collect_children
    menu.unshift({ :uri => url_for(:root), :name => 'Home', :ico => 'fa fa-home' })
    menu
  end

  private

  def collect_children(parent = nil)
    menu = []
    @models.each do |model_reflection|
      if model_reflection.parent_menu_item == parent
        model = model_reflection.model
        menu << { :model => model, :sub => collect_children(model.to_s) }
      end
    end
    menu
  end

end