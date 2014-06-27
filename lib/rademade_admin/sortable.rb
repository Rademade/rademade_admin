#todo move to concern dir
module RademadeAdmin
  module Sortable
    extend ActiveSupport::Concern

    included do
      #todo think how will it work with data adapter
      field :position, :type => Integer
      default_scope -> { order_by(:position => :asc) }

      set_callback(:create, :after) do |document|
        #todo check self -> document
        self.position = self.class.max(:position).to_i + 1
        self.save
      end
    end

  end
end
