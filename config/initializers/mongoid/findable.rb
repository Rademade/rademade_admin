# encoding: utf-8
module Mongoid
  module Findable

    def prepend_order_by(*args)
      with_default_scope.prepend_order_by(*args)
    end

  end
end