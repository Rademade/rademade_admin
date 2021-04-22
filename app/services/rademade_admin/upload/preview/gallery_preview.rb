# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class Preview
      class GalleryPreview < RademadeAdmin::Upload::Preview

        def preview_html(uploader, options = { editable: true, destroyable: true })
          content_tag(:div, image_item_html(uploader, options),
            class: 'upload-holder',
            data: image_data(uploader)
          )
        end

        def gallery_image_preview(uploader)
          uploader.resize_with_crop(300, 300)
        end

        protected

        def crop_url
          rademade_admin_route(:gallery_crop_url)
        end

        private

        def image_item_html(uploader, options)
          html_parts = [image_html(uploader)]
          html_parts << remove_ico_html if options[:destroyable]
          content_tag(
            :div,
            HtmlBuffer.new(html_parts),
            class: 'upload-item'
          )
        end

        def image_html(uploader)
          content_tag(:img, '', src: gallery_image_preview(uploader))
        end

        def remove_ico_html
          content_tag(:i, '',
            class: 'upload-delete',
            data: {
              remove: ''
            }
          )
        end

      end
    end
  end
end
