module RademadeAdmin
  module Uploader
    module Photo

      def method_missing(name, *arguments)
        if name == 'resize'
          raise NotImplemented.new 'Implement "resize" error'
        end
      end

    end
  end
end