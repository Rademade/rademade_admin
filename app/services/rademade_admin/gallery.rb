# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Gallery

    def method_missing(name, *arguments)
      if name == 'images'
        raise NotImplementedError.new 'Implement "images" method'
      end
      super
    end

  end
end
