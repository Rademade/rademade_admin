# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Uploader

        attr_reader :name, :uploader

        def initialize(name, uploader)
          @name, @uploader = name, uploader
        end

      end
    end
  end
end