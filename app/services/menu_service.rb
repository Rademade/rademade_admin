# -*- encoding : utf-8 -*-
module RademadeAdmin
  class MenuService
    include Singleton

    def main_menu
      @main_menu ||= collect_children
    end

    private

    def initialize
      @model_infos = RademadeAdmin::Model::Graph.instance.root_models
    end

    def collect_children(parent_model = nil)
      menu_items = []
      @model_infos.each do |model_info|
        if model_info.parent_model == parent_model && model_info.display_in_menu?
          menu_items << RademadeAdmin::MenuService::MenuItem.new(model_info, collect_children(model_info.model))
        end
      end
      menu_items
    end

  end
end