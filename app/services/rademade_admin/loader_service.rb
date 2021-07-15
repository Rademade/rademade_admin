# -*- encoding : utf-8 -*-
module RademadeAdmin
  class LoaderService
    def self.const_get(name)
      name.classify.constantize
    end
  end
end
