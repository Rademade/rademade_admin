module RademadeAdmin
  module Model
    class Reflection
      module Uploader

        def uploaders
          @model.respond_to?(:uploaders) ? @model.uploaders : []
        end

        def uploader_fields
          @model.respond_to?(:uploaders) ? @model.uploaders.keys : []
        end

      end
    end
  end
end