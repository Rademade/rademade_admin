module RademadeAdmin
  module Gallery
    class Manager

      attr_reader :gallery_images_html

      def initialize(class_name)
        init_gallery_models(class_name)
      end

      def upload_images(gallery_id, files)
        find_gallery gallery_id
        gallery_images = upload_gallery_images(files)
        save_gallery_images(gallery_images)
      end

      def crop_image(image_id, crop_data)
        gallery_image = @gallery_image_info.query_adapter.find(image_id)
        uploader = gallery_image.image
        image = uploader.crop_image(crop_data)
        uploader.store!(image)
        @gallery_image_info.persistence_adapter.save(gallery_image)
        uploader
      end

      def remove_image(image_id)
        gallery_image = @gallery_image_info.query_adapter.find(image_id)
        @gallery_image_info.persistence_adapter.destroy(gallery_image)
      end

      def sort_images(images)
        sort_gallery_images images
      end

      private

      def init_gallery_models(class_name)
        @gallery_info = RademadeAdmin::Model::Graph.instance.model_info(class_name)
        @gallery_image_data_item = @gallery_info.data_items.data_item(:images)
        @gallery_image_relation = @gallery_image_data_item.relation
        @gallery_image_info = RademadeAdmin::Model::Graph.instance.model_info(@gallery_image_relation.to)
      end

      def find_gallery(gallery_id)
        @gallery = @gallery_info.query_adapter.find(gallery_id)
      end

      def upload_gallery_images(images)
        preview_service = RademadeAdmin::Upload::Preview::Gallery.new
        @gallery_images_html = []
        images.map do |image|
          gallery_image = @gallery_image_info.persistence_adapter.new_record
          @gallery_image_info.persistence_adapter.save(gallery_image)
          gallery_image.image.store! image
          update_gallery_image_position(gallery_image)
          @gallery_images_html << preview_service.preview_html(gallery_image.image)
          gallery_image
        end
      end

      def save_gallery_images(gallery_images)
        @gallery_image_data_item.set_data(@gallery, @gallery.images + gallery_images)
        gallery_images.each do |gallery_image|
          @gallery_image_info.persistence_adapter.save(gallery_image)
        end
        @gallery_info.persistence_adapter.save(@gallery)
      end

      def sort_gallery_images(images)
        images.each_with_index do |image_id, index|
          gallery_image = @gallery_info.query_adapter.find(image_id)
          set_gallery_image_position(gallery_image, index)
          @gallery_image_info.persistence_adapter.save(gallery_image)
        end
      end

      def update_gallery_image_position(gallery_image)
        if @gallery_image_relation.sortable?
          last_image = @gallery.images.last
          previous_position = last_image.nil? ? 0 : last_image.send(:"#{@gallery_image_relation.sortable_field}")
          set_gallery_image_position(gallery_image, previous_position + 1)
        end
      end

      def set_gallery_image_position(gallery_image, position)
        gallery_image.send(:"#{@gallery_image_relation.sortable_field}=", position)
      end

    end
  end
end