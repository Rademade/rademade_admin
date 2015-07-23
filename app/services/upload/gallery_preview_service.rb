# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class GalleryPreviewService

      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include UriHelper

      def preview_html(uploader)
        content_tag(:div, image_item_html(uploader),
          :class => 'upload-photo-holder',
          :data => {
            :id => uploader.model.id.to_s
          }
        )
      end

      private

      def image_item_html(uploader)
        content_tag(
          :div,
          HtmlBuffer.new([image_html(uploader), remove_ico_html(uploader)]),
          :class => 'upload-photo-item'
        )
      end

      def image_html(uploader)
        content_tag(:img, '', :src => uploader.resize_with_crop(300, 300))
      end

      def remove_ico_html(uploader)
        content_tag(:i, '',
          :class => 'upload-photo-delete',
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

      # def crop_button_html(uploader)
      #   content_tag(:span, I18n.translate('rademade_admin.uploader.crop'), {
      #     :class => 'btn red-btn crop-btn',
      #     :data => {
      #       :crop => true,
      #       :url => rademade_admin_route(:gallery_crop_url),
      #       :full_url => uploader.url,
      #       :original_dimensions => uploader.original_dimensions.join(',')
      #     }
      #   }) if uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
      # end

    end
  end
end