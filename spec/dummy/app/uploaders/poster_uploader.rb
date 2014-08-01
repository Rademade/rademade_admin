# encoding: utf-8
class PosterUploader < CarrierWave::Uploader::Base

  storage :file

  include LightResizer::CarrierWaveResize
  include RademadeAdmin::Uploader::Photo

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
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


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:


  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
