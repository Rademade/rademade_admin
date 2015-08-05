# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class Preview
      class File < RademadeAdmin::Upload::Preview

        include ActionView::Helpers::NumberHelper

        def initialize(uploader)
          @uploader = uploader
        end

        def preview_html
          content_tag(:div, uploaded_file_html)
        end

        def uploaded_file_html
          if is_image?
            uploaded_image_preview
          elsif is_video?
            uploaded_video_preview
          else
            uploaded_file_default_preview
          end
        end

        def is_image?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::Photo
        end

        def is_crop?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::CropPhoto
        end

        def is_video?
          @uploader.class.ancestors.include? RademadeAdmin::Uploader::Video
        end

        private

        def uploaded_image_preview
          content_tag(:img, '', {
            :src => @uploader.resize_with_crop(300, 300),
            :data => image_data(@uploader).merge(
              :image_preview => ''
            )
          })
        end

        def uploaded_video_preview
          content_tag(:img, '', {
            :src => @uploader.thumb_path,
          })
        end

        def uploaded_file_default_preview
          file_path = @uploader.file.file
          content_tag(:span, "#{::File.basename(file_path)}, #{number_to_human_size(::File.size(file_path))}")
        end

      end
    end
  end
end