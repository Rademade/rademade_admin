# -*- encoding : utf-8 -*-
require 'rademade_admin/uploader/photo'

module RademadeAdmin
  module Uploader
    module CropPhoto
      include ::RademadeAdmin::Uploader::Photo

      def crop_image(image_path, params)
        crop( full_image_path(image_path), params[:x], params[:y], params[:w], params[:h] )
      end

      def original_dimensions
        if file && model
          image = Magick::Image.read(file.file).first
          [image.columns, image.rows]
        else
          []
        end
      end

    end
  end
end
