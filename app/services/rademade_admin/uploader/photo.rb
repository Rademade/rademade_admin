# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Uploader
    module Photo

      def method_missing(name, *arguments)
        raise NotImplemented.new 'Implement "resize" error' if name == 'resize'
        super
      end

      def delete_other_images(image_path)
        filename = File.basename(image_path)

        store_path = full_image_path(store_dir)

        return unless File.exist? store_path

        Dir.foreach(store_path) do |item|
          next if item == '.' or item == '..'
          if File.basename(item) != filename
            FileUtils.rm_r(File.join(store_path, item))
          end
        end
      end

      protected

      #
      # todo problem with other storages
      #
      def full_image_path(image_path)
        File.join(Rails.root, 'public', image_path)
      end

    end
  end
end
