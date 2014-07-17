# -*- encoding : utf-8 -*-
#todo move to concern dir
module RademadeAdmin
  module Sortable

    def method_missing(name, *arguments)
      if name == 'position'
        raise NotImplementedError.new 'Implement "position" method'
      end
    end

  end
end
