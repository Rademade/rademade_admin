# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class PreviewService

      include ActionView::Helpers::TagHelper
      include ActionView::Context

      def initialize(uploader)
        @uploader = uploader
      end

      def preview_html
        content_tag(:div, :class => ['preview-wrapper', preview_style_class].join(' ')) do
          if @uploader.blank?
            empty_file_html
          else
            uploaded_file_html
          end
        end
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

      private

      def empty_file_html
        content_tag(:span, I18n.t('rademade_admin.file_not_chosen'), {
          :class => 'no-file'
        })
      end

      def preview_style_class
        if is_image?
          'image-preview-wrapper'
        elsif is_video?
          'video-preview-wrapper'
        else
          'file-preview-wrapper'
        end
      end

      def is_image?
        @uploader.class.ancestors.include? RademadeAdmin::Uploader::Photo
      end

      def is_video?
        @uploader.class.ancestors.include? RademadeAdmin::Uploader::Video
      end

      def uploaded_image_preview
        content_tag(:img, '', {
          :src => @uploader.resize(230, 130),
          :class => 'image-preview',
          :width => 230,
          :height => 130
        })
      end

      def uploaded_video_preview
        content_tag(:img, '', {
          :src => @uploader.thumb_path,
          :class => 'video-preview',
          :width => 300
        })
      end

      def uploaded_file_default_preview
        file_path = @uploader.file.file
        text = "#{File.basename(file_path)}, #{RademadeAdmin::FileInfoFormatter.format_size(File.size(file_path))}"
        content_tag(:span, text, {
          :class => 'file-uploaded'
        })
      end

    end
  end
end