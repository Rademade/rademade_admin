# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class ImagePresenter

      attr_reader :gallery_images, :gallery_images_html

      def initialize(gallery)
        @gallery = gallery
        @mounted_as = gallery.images.model.uploaders.keys.first
      end

      def upload_gallery_images(images)
        @gallery_images = []
        @gallery_images_html = []
        images.each { |image| add_gallery_image upload_gallery_image(image) }
      end

      protected

      def upload_gallery_image(image)
        @gallery.images.create(@mounted_as => image)
      end

      def add_gallery_image(gallery_image)
        @gallery_images << gallery_image
        @gallery_images_html << preview_service.preview_html(gallery_image.send(@mounted_as))
      end

      def preview_service
        @preview_service ||= RademadeAdmin::Upload::Preview::Gallery.new
      end

    end
  end
end