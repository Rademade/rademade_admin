# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Uploader
    module CropPhoto
      include ::RademadeAdmin::Uploader::Photo

      def crop_image(params, image_path = nil)
        crop_path = image_path ? full_image_path(image_path) : path
        crop(crop_path, params[:x], params[:y], params[:w], params[:h])
      end

      def crop(image_path, x, y, width, height)
        image = ::Magick::Image.read(image_path).first
        image.crop!(x.to_i, y.to_i, width.to_i, height.to_i, true)
        image.write("#{Rails.root}/tmp/cache/#{x}_#{y}_#{width}_#{height}_#{/([^\/]*)$/.match(image_path)[1]}")
        File.open(image.filename)
      end

      def original_dimensions
        if file && model
          image = Magick::Image.ping(file.file).first
          [image.columns, image.rows]
        else
          []
        end
      end

    end
  end
end
