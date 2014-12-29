# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class GalleryPreviewService

      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include UriHelper

      def preview_html(uploader)
        content_tag(:div, HtmlBuffer.new([
          gallery_image_html(uploader),
          remove_ico_html(uploader)
        ]), {
          :class => 'gallery-image',
          :data => {
            :id => uploader.model.id.to_s
          }
        })
      end

      private

      def gallery_image_html(uploader)
        content_tag(:img, '', {
          :src => uploader.resize(150, 100),
          :width => 150,
          :height => 100
        })
      end

      def remove_ico_html(uploader)
        content_tag(:span, 'x', {
          :class => 'remove-ico',
          :data => {
            :url => admin_url_for(
              :controller => 'gallery',
              :action => 'remove',
              :id => uploader.model.id.to_s
            )
          }
        })
      end

    end
  end
end