# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Uploader

        attr_reader :name, :uploader

        def initialize(name, uploader)
          @name, @uploader = name, uploader
        end
        
        def remove_method
          "remove_#{name}!"
        end

        def full_path_for(image_path)
          "#{CarrierWave.root}#{image_path}"
        end

      end
    end
  end
end