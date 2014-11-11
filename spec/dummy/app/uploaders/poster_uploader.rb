# encoding: utf-8
class PosterUploader < CarrierWave::Uploader::Base

  include LightResizer::CarrierWaveResize
  include RademadeAdmin::Uploader::Photo

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def crop_image(image_path, crop_params)
    crop(full_image_path(image_path), crop_params[:x], crop_params[:y], crop_params[:w], crop_params[:h])
  end

  def filename
    if original_filename == File.basename(model.send(mounted_as).to_s)
      super
    else
      Digest::MD5.hexdigest(super) << File.extname(super) if super
    end
  end

  def original_dimensions
    if file && model
      image = Magick::Image.read(file.file).first
      [image.columns, image.rows]
    else
      []
    end
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def delete_other_images(new_image)

    new_file = File.basename(new_image)

    full_path = full_image_path(store_dir)

    return unless File.exist? full_path

    Dir.foreach(full_path) do |item|
      next if item == '.' or item == '..'

      if File.basename(item) != new_file
        FileUtils.rm_r(File.join(full_path, item))
      end
    end
  end

  private

  def full_image_path(image_path)
    File.join(Rails.root, 'public', image_path)
  end

end
