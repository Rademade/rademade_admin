# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Uploaders

        def initialize(data_adapter)
          @data_adapter = data_adapter
        end

        def all
          @data_adapter.uploaders
        end

        def uploader(name)
          @data_adapter.uploader(name)
        end

      end
    end
  end
end