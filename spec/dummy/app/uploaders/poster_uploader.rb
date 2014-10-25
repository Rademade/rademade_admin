# encoding: utf-8
class PosterUploader < CarrierWave::Uploader::Base

  include LightResizer::CarrierWaveResize
  include RademadeAdmin::Uploader::Photo

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def cropped_image(image_path, params)
    image = MiniMagick::Image.open(File.join(Rails.root, 'public', image_path))
    image.crop("#{params[:w]}x#{params[:h]}+#{params[:x]}+#{params[:y]}")
    image
  end

  def filename
    if original_filename == File.basename(model.send(mounted_as).to_s)
      super
    else
      Digest::MD5.hexdigest(super) << File.extname(super) if super
    end
  end

  def original_dimensions
    return MiniMagick::Image.open(file.file)[:dimensions] if file && model
    []
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def delete_other_images(new_image)

    new_file = File.basename(new_image)

    full_path = File.join(Rails.root, 'public', store_dir)

    return unless File.exist? full_path

    Dir.foreach(full_path) do |item|
      next if item == '.' or item == '..'

      if File.basename(item) != new_file
        FileUtils.rm_r(File.join(full_path, item))
      end
    end
  end

end
