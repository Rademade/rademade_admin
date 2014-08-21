# encoding: utf-8
module Mongoid
  module Relations
    module Options

      COMMON = [
        :class_name,
        :counter_cache,
        :extend,
        :inverse_class_name,
        :inverse_of,
        :name,
        :relation,
        :validate,
        :sortable
      ]

    end
  end
end