# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class Preview

      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include UriHelper

      def image_data(uploader)
        data = {
          :image_id => uploader.model.id.to_s,
          :full_url => uploader.url,
          :name => uploader.file.try(:filename)
        }
        data[:crop] = crop_data(uploader) if uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
        data
      end

      def crop_data(uploader)
        {
          :url => crop_url,
          :original_dimensions => uploader.original_dimensions.join(',')
        }
      end

      protected

      def crop_url
        nil
      end

    end
  end
end