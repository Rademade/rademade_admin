#todo move to concern dir
module RademadeAdmin
  module Sortable
    extend ActiveSupport::Concern

    included do
      field :position, :type => Integer
      default_scope -> { order_by(:position => :asc) }

      set_callback(:create, :after) do |document|
        self.position = self.class.max(:position).to_i + 1
        self.save
      end
    end
  end
end
