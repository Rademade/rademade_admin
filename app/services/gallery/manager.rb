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
        @gallery_image_relation.to.find(image_id).destroy
      end

      def sort_images(images)
        sort_gallery_images images
      end

      private

      def init_gallery_models
        gallery_info = RademadeAdmin::Model::Graph.instance.model_info(@class_name)
        @gallery_model = gallery_info.model
        @gallery_image_relation = gallery_info.data_items.data_item(:images).relation
      end

      def find_gallery(gallery_id)
        @gallery = @gallery_model.find(gallery_id)
      end

      def upload_gallery_images(images)
        preview_service = RademadeAdmin::Upload::GalleryPreviewService.new
        @gallery_images_html = []
        images.each do |image|
          gallery_image = @gallery_image_relation.to.create
          gallery_image.image.store! image
          update_gallery_image_position(gallery_image)
          @gallery.images << gallery_image
          @gallery_images_html << preview_service.preview_html(gallery_image.image)
        end
      end

      def sort_gallery_images(images)
        images.each_with_index do |image_id, index|
          gallery_image = @gallery_image_relation.to.find(image_id)
          set_gallery_image_position(gallery_image, index)
          gallery_image.save
        end
      end

      def update_gallery_image_position(gallery_image)
        if @gallery_image_relation.sortable?
          previous_position = @gallery.images.last.send(:"#{@gallery_image_relation.sortable_field}")
          set_gallery_image_position(gallery_image, previous_position + 1)
        end
      end

      def set_gallery_image_position(gallery_image, position)
        gallery_image.send(:"#{@gallery_image_relation.sortable_field}=", position)
      end

    end
  end
end