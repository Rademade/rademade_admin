# -*- encoding : utf-8 -*-
module Autocomplete
  class LinkSerializer < BaseSerializer

    def initialize(collection, item, relation)
      super(collection)
      @item = item
      @relation = relation
    end

    protected

    def item_to_json(item)
      super(item).merge({
        :link_url => admin_link_uri(@item, @relation, {
          :related_id => item.id
        })
      })
    end

  end
end
