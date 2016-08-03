module RademadeAdmin
  module Gallery
    class Manager

      def initialize(class_name)
        @class_name = class_name
      end

      def upload_images(gallery_id, files)
        @gallery = gallery_info.query_adapter.find(gallery_id)
        @mounted_as = @gallery.images.model.uploaders.keys.first

        image_presenter = upload_gallery_images(files)
        save_gallery_images(image_presenter.gallery_images)
        
        image_presenter.gallery_images.map{|image| preview_service.preview_html(image.send(@mounted_as)) }
      end

      def crop_image(image_id, crop_data)
        gallery_image = gallery_image_info.query_adapter.find(image_id)
        mounted_as = gallery_image.class.uploaders.keys.first
        uploader = gallery_image.send(mounted_as)
        image = uploader.crop_image(crop_data)
        uploader.store!(image)
        gallery_image_info.persistence_adapter.save(gallery_image)
        uploader
      end

      def remove_image(image_id)
        gallery_image = gallery_image_info.query_adapter.find(image_id)
        gallery_image_info.persistence_adapter.destroy(gallery_image)
      end

      def sort_images(images)
        sort_gallery_images images
      end

      protected

      def gallery_info
        @gallery_info ||= RademadeAdmin::Model::Graph.instance.model_info(@class_name)
      end

      def gallery_image_data_item
        @gallery_image_data_item ||= gallery_info.data_items.data_item(:images)
      end

      def gallery_image_relation
        @gallery_image_relation ||= gallery_image_data_item.relation
      end

      def gallery_image_info
        @gallery_image_info ||= RademadeAdmin::Model::Graph.instance.model_info(gallery_image_relation.to)
      end

      def upload_gallery_images(images)
        image_presenter = RademadeAdmin::Upload::ImagePresenter.new(gallery_image_info.persistence_adapter)
        image_presenter.upload_gallery_images(images)
        image_presenter
      end

      def save_gallery_images(gallery_images)
        gallery_image_data_item.set_data(@gallery, @gallery.images + gallery_images)
        gallery_images.each do |gallery_image|
          update_gallery_image_position(gallery_image)
          gallery_image_info.persistence_adapter.save(gallery_image)
        end
        gallery_info.persistence_adapter.save(@gallery)
      end

      def sort_gallery_images(images)
        images.each_with_index do |image_id, index|
          gallery_image = gallery_image_info.query_adapter.find(image_id)
          set_gallery_image_position(gallery_image, index)
          gallery_image_info.persistence_adapter.save(gallery_image)
        end
      end

      def update_gallery_image_position(gallery_image)
        if gallery_image_relation.sortable?
          last_image = @gallery.images.last
          previous_position = last_image.nil? ? 0 : last_image.send(gallery_image_relation.sortable_field.to_sym)
          set_gallery_image_position(gallery_image, previous_position + 1)
        end
      end

      def set_gallery_image_position(gallery_image, position)
        gallery_image.send(:"#{gallery_image_relation.sortable_field}=", position)
      end

      def preview_service
        @preview_service ||= RademadeAdmin::Upload::Preview::Gallery.new
      end

    end
  end
end