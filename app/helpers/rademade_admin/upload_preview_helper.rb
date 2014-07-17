# -*- encoding : utf-8 -*-
module RademadeAdmin::UploadPreviewHelper

  include ActionView::Helpers::TagHelper
  include ActionView::Context

  #@param uploader [CarrierWave::Uploader::Base]
  def file_preview_html(uploader)
    content_tag(:div, :class => 'image-preview-wrapper') do
      if uploader.blank?
        empty_file_html(uploader)
      else
        uploaded_file_html(uploader)
      end
    end
  end

  def empty_file_html(uploader)
    content_tag(:span, 'File not chosen', {
      :class => 'no-file'
    })
  end

  def uploaded_file_html(uploader)
    included_modules = uploader.class.ancestors
    if included_modules.include? RademadeAdmin::Uploader::Photo
      uploaded_image_preview(uploader)
    elsif included_modules.include? RademadeAdmin::Uploader::Video
      uploaded_video_preview(uploader)
    else
      uploaded_file_default_preview(uploader)
    end
  end

  def uploaded_image_preview(uploader)
    content_tag(:img, '', {
      :src => uploader.resize(200, 200),
      :class => 'image-preview',
      :width => 200,
      :height => 200
    })
  end

  def uploaded_video_preview(uploader)
    content_tag(:img, '', {
      :src => uploader.thumb_path,
      :class => 'video-preview',
      :width => 300
    })
  end

  def uploaded_file_default_preview(uploader)
    file_path = uploader.file.file
    text = File.basename(file_path) + ', ' + RademadeAdmin::FileInfoFormatter.format_size(File.size(file_path))
    content_tag(:span, text, {
      :class => 'file-uploaded'
    })
  end

end
