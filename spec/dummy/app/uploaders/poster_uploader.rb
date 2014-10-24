# encoding: utf-8
class PosterUploader < CarrierWave::Uploader::Base

  include LightResizer::CarrierWaveResize
  include RademadeAdmin::Uploader::Photo

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def cropped_image(params)
    image = MiniMagick::Image.open(self.image.path)
    crop_params = "#{params[:w]}x#{params[:h]}+#{params[:x]}+#{params[:y]}"
    image.crop(crop_params)

    image
  end

  def filename
    if original_filename == File.basename(model.send(mounted_as).to_s)
      super
    else
      Digest::MD5.hexdigest(super) << File.extname(super) if super
    end
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
