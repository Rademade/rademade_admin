# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class ImagePresenter

      attr_reader :gallery_images, :gallery_images_html

      def initialize(gallery_image_persistence_adapter)
        @gallery_image_persistence_adapter = gallery_image_persistence_adapter
      end

      def upload_gallery_images(images)
        @gallery_images = []
        @gallery_images_html = []
        images.each { |image| add_gallery_image upload_gallery_image(image) }
      end

      protected

      def upload_gallery_image(image)
        gallery_image = @gallery_image_persistence_adapter.new_record
        @gallery_image_persistence_adapter.save(gallery_image)
        gallery_image.image.store! image
        gallery_image
      end

      def add_gallery_image(gallery_image)
        @gallery_images << gallery_image
        @gallery_images_html << preview_service.preview_html(gallery_image.image)
      end

      def preview_service
        @preview_service ||= RademadeAdmin::Upload::Preview::Gallery.new
      end

    end
  end
end