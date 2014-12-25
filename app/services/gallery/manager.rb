module RademadeAdmin
  module Gallery
    class Manager

      attr_reader :gallery_images_html

      def initialize(class_name)
        @class_name = class_name
        init_gallery_models
      end

      def upload_images(gallery_id, files)
        find_gallery gallery_id
        upload_gallery_images files
        @gallery.save
      end

      def remove_image(image_id)
        @gallery_image_model.find(image_id).destroy
      end

      private

      def init_gallery_models
        gallery_info = RademadeAdmin::Model::Graph.instance.model_info(@class_name)
        @gallery_model = gallery_info.model
        @gallery_image_model = gallery_info.data_items.data_item(:images).relation.to
      end

      def find_gallery(gallery_id)
        @gallery = @gallery_model.find(gallery_id)
      end

      def upload_gallery_images(images)
        preview_service = RademadeAdmin::Upload::GalleryPreviewService.new
        @gallery_images_html = []
        images.each do |image|
          gallery_image = @gallery_image_model.create
          gallery_image.image.store! image
          @gallery.images << gallery_image
          @gallery_images_html << preview_service.preview_html(gallery_image.image)
        end
      end

    end
  end
end