# -*- encoding : utf-8 -*-
module RademadeAdmin::MenuHelper

  PARENT_LESS_MENU_KEY = :_parent_less unless const_defined?(:PARENT_LESS_MENU_KEY)

  def main_menu
    build_menu_data RademadeAdmin::Model::Graph.instance.model_infos
    build_menu
  end

  def active?(menu_item)
    if menu_item[:is_current]
      true
    else
      menu_item[:sub].each do |sub_item|
        return true if active?(sub_item)
      end
      false
    end
  end

  private

  def build_menu_data(model_infos)
    @menu_data = {}
    model_infos.each do |_, model_info|
      menu_key = (model_info.parent_menu || PARENT_LESS_MENU_KEY).to_s
      @menu_data[menu_key] ||= []
      @menu_data[menu_key] << model_info
    end
  end

  def build_menu
    menu = [root_url]
    menu += collect_children(PARENT_LESS_MENU_KEY)
    @menu_data.each do |menu_key, _|
      menu += [{
        :name => menu_key,
        :is_current => false,
        :sub => collect_children(menu_key)
      }]
    end
    menu
  end

  def collect_children(menu_key)
    menu = []
    menu_key = menu_key.to_s
    unless @menu_data[menu_key].nil?
      @menu_data[menu_key].each do |model_info|
        uri = current_ability.can?(:read, model_info.model) ? admin_list_uri(model_info) : nil
        menu << {
          :uri => uri,
          :name => model_info.item_name,
          :sub => collect_children(model_info.model),
          :count => model_info.menu_count,
          :is_current => current_menu?(uri, model_info)
        }
      end
      @menu_data.delete(menu_key)
    end
    menu
  end

  def root_url
    uri = root_uri
    {
      :uri => uri,
      :name => t('rademade_admin.home'),
      :is_current => current_page?(uri),
      :sub => []
    }
  end

  def current_menu?(uri, model_info)
    model_info == @model_info or (not uri.nil? and current_page?(uri))
  end

end