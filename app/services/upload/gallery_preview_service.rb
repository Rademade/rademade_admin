# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class GalleryPreviewService

      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include UriHelper

      def preview_html(uploader)
        content_tag(:div, image_item_html(uploader),
          :class => 'upload-holder',
          :data => image_data(uploader)
        )
      end
      
      def gallery_image_preview(uploader)
        uploader.resize_with_crop(300, 300)
      end

      def crop_data(uploader)
        {
          :url => rademade_admin_route(:gallery_crop_url),
          :full_url => uploader.url,
          :original_dimensions => uploader.original_dimensions.join(',')
        }
      end

      private

      def image_item_html(uploader)
        content_tag(
          :div,
          HtmlBuffer.new([image_html(uploader), remove_ico_html(uploader)]),
          :class => 'upload-item'
        )
      end

      def image_html(uploader)
        content_tag(:img, '', :src => gallery_image_preview(uploader))
      end

      def remove_ico_html(uploader)
        content_tag(:i, '',
          :class => 'upload-delete',
          :data => {
            #todo use route name and resources
            :'remove-url' => admin_url_for({
              :controller => 'rademade_admin/gallery',
              :action => 'remove',
              :id => uploader.model.id.to_s
            })
          }
        )
      end

      def image_data(uploader)
        data = { :id => uploader.model.id.to_s }
        data[:crop] = crop_data(uploader) if uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
        data
      end

    end
  end
end