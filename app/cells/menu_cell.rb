class MenuCell < Cell::Rails
  include ::RademadeAdmin::UriHelper

  class << self
    attr_accessor :current_model, :current_ability
  end

  def root_item
    @uri = root_uri
    @name = t('rademade_admin.home')
    @ico_class = 'glyphicon glyphicon-home'
    @has_sub_items = false
    @is_active = self.class.current_model.nil?
    render view: :item
  end

  def item(item)
    item_data(item)
    render
  end

  def sub_items(sub_items)
    @sub_items = sub_items
    render
  end

  def sub_item(sub_item)
    item_data(sub_item)
    render
  end

  private

  def item_data(item)
    @is_active = current?(item) || children_current?(item) #todo extract service for current
    @uri = can_read?(item) ? admin_list_uri(item.model) : nil
    @name = item.name
    @has_sub_items = item.has_sub_items?
    @sub_items = item.sub_items
  end

  def current?(item)
    self.class.current_model == item.model
  end

  def can_read?(item) # todo move authorize check to uri helper
    self.class.current_ability.can?(:read, item.model)
  end

  def children_current?(item, status = false)
    if item.has_sub_items?
      item.sub_items.each do |sub_item|
        status ||= current?(sub_item) || children_current?(sub_item)
      end
    end
    status
  end

end
