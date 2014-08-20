# encoding: utf-8
class VideoUploader < CarrierWave::Uploader::Base

  include RademadeAdmin::Uploader::Video

  storage :file

  def store_dir
    "uploads/video/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    Digest::MD5.hexdigest(original_filename) << File.extname(original_filename) if original_filename
  end

  def content_type
    video_mime_type(MIME::Types.type_for(file.filename))
  end

  def extension_white_list
    %w(avi mp4)
  end

  def thumb_path
    file_path = file.file
    thumb_path = File.dirname(file_path) + '/' + File.basename(file_path, '.*') + '.png'
    RademadeAdmin::VideoService.new(file_path).take_random_screenshot(thumb_path) unless File.exists?(thumb_path)
    thumb_path.gsub(/^#{Rails.public_path}/, '')
  end

  private

  def video_mime_type(mime_types)
    mime_types.each do |mime_type|
      return mime_type if mime_type.media_type == 'video'
    end
    nil
  end

end