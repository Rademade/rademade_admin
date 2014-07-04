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
    if uploader.is_a? PosterUploader # todo remove hard code
      uploaded_image_preview(uploader)
    elsif uploader.is_a? VideoUploader # todo remove hard code
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
    file_path = uploader.file.file
    #image_uploader = RademadeAdmin::VideoService.generate_thumb_uploader(uploader)
    thumb_path = File.dirname(file_path) + '/' + File.basename(file_path, '.*') + '.png'
    RademadeAdmin::VideoService.new(file_path).take_random_screenshot(thumb_path) unless File.exists?(thumb_path)
    content_tag(:img, '', {
      :src => thumb_path.gsub(/^#{Rails.public_path}/, ''), #todo
      :class => 'video-preview',
      :width => 300
    })
  end

  def uploaded_file_default_preview(uploader)
    file_path = uploader.file.file
    text = File.basename(file_path) + ', ' + FileInfoFormatter.format_size(File.size(file_path))
    content_tag(:span, text, {
      :class => 'file-uploaded'
    })
  end

end