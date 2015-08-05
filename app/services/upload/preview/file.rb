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
          content_tag(:div, uploaded_file_html, :data => { :preview_item => '' })
        end

        def uploaded_file_html
          if @uploader.blank? || @uploader.size.zero?
            ''
          elsif is_image?
            image_preview_html
          elsif is_video?
            video_preview_html
          else
            file_preview_html
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

        def image_preview
          @uploader.resize_with_crop(300, 300)
        end

        private

        def image_preview_html
          content_tag(:img, '', {
            :src => image_preview,
            :data => image_data(@uploader).merge(
              :image_preview => ''
            )
          })
        end

        def video_preview_html
          content_tag(:img, '', {
            :src => @uploader.thumb_path,
          })
        end

        def file_preview_html
          file_path = @uploader.file.file
          content_tag(:span, "#{::File.basename(file_path)}, #{number_to_human_size(::File.size(file_path))}")
        end

        def crop_url
          rademade_admin_route(:file_crop_url)
        end

      end
    end
  end
end