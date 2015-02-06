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
          remove_ico_html(uploader),
          crop_button_html(uploader)
        ]), {
          :class => 'gallery-image',
          :data => {
            :id => uploader.model.id.to_s
          }
        })
      end

      def crop_button_html(uploader)
        content_tag(:span, I18n.translate('rademade_admin.crop'), {
          :class => 'btn red-btn crop-btn',
          :data => {
            :crop => true,
            :url => admin_url_for(:controller => 'gallery', :action => 'crop'),
            :full_url => uploader.url,
            :original_dimensions => uploader.original_dimensions.join(',')
          }
        }) if uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
      end

      def gallery_image_preview(uploader)
        uploader.resize(150, 100)
      end

      private

      def gallery_image_html(uploader)
        content_tag(:img, '', {
          :src => gallery_image_preview(uploader),
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