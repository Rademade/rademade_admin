# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class ImagePresenter

      attr_reader :gallery_images, :gallery_images_html

      def upload_gallery_images(gallery_image_persistence_adapter, images)
        @gallery_images = []
        @gallery_images_html = []
        preview_service = RademadeAdmin::Upload::Preview::Gallery.new
        images.each do |image|
          gallery_image = gallery_image_persistence_adapter.new_record
          gallery_image_persistence_adapter.save(gallery_image)
          gallery_image.image.store! image
          @gallery_images << gallery_image
          @gallery_images_html << preview_service.preview_html(gallery_image.image)
        end
      end

    end
  end
end