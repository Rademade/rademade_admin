# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Uploader
    module Photo

      def method_missing(name, *arguments)
        if name == 'resize'
          raise NotImplemented.new 'Implement "resize" error'
        end
        super
      end

    end
  end
end
