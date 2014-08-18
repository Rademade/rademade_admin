class FileUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/files/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    Digest::MD5.hexdigest(original_filename) << File.extname(original_filename) if original_filename
  end

end