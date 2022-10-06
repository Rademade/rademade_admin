# encoding: utf-8
module RademadeAdmin
  module Uploader
    class CarrierWave < CarrierWave::Uploader::Base
      include ::LightResizer::CarrierWaveResize
      include ::RademadeAdmin::Uploader::CropPhoto

      storage :file

      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
      end

      def filename
        if original_filename == File.basename(model.send(mounted_as).to_s)
          super
        else
          Digest::MD5.hexdigest(super) << File.extname(super) if super
        end
      end

      def extension_white_list
        %w(jpg jpeg png gif)
      end

    end
  end
end
