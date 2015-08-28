class MenuCell < Cell::Rails
  include ::RademadeAdmin::UriHelper

  class << self
    attr_accessor :current_model, :current_ability
  end

  def root_item
    @uri = root_uri
    @name = t('rademade_admin.home')
    @count = nil
    @has_sub_items = false
    @is_active = self.class.current_model.nil?
    @hide = false
    render view: :item
  end

  def item(item, hide_not_active = false)
    item_data(item)
    @hide = hide_not_active || @uri.nil?
    render
  end

  def sub_items(sub_items, hide_not_active)
    @sub_items = sub_items
    @hide_not_active = hide_not_active
    render
  end

  private

  def item_data(item)
    @is_active = current?(item) || children_current?(item)
    @uri = can_read?(item) ? admin_list_uri(item.model) : nil
    @name = item.name
    @count = item.count
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
