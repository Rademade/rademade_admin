module Autocomplete
  class LinkSerializer < BaseSerializer

    def initialize(collection, parent, parent_id)
      super(collection)
      @parent = parent
      @parent_id = parent_id
    end

    protected

    def item_to_json(item)
      super(item).merge({
        :link_url => admin_link_uri(item, @parent, @parent_id)
      })
    end

  end
end