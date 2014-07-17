# -*- encoding : utf-8 -*-
module Sortable
  include RademadeAdmin::Sortable
  extend ActiveSupport::Concern

  included do

    field :position, :type => Integer
    default_scope -> { order_by(:position => :asc) }

    set_callback(:create, :before) do
      self.position = self.class.max(:position).to_i + 1
    end

  end

end
