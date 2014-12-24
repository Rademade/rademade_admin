module RademadeAdmin
  module Gallery
    class Manager

      attr_reader :gallery_images_html

      def initialize(params)
        @params = params
      end

      def upload_images
        init_gallery_models
        find_or_create_gallery
        init_gallery_images_html
        @gallery.save
      end

      def remove_image
        init_gallery_models
        @gallery_image_model.find(@params[:id]).destroy
      end

      private

      def init_gallery_models
        gallery_info = RademadeAdmin::Model::Graph.instance.model_info(@params[:class_name])
        @gallery_model = gallery_info.model
        @gallery_image_model = gallery_info.data_items.data_item(:images).relation.to
      end

      def find_or_create_gallery
        @gallery = @gallery_model.find(@params[:gallery]) rescue nil
        @gallery = @gallery_model.new if @gallery.nil?
      end

      def init_gallery_images_html
        preview_service = RademadeAdmin::Upload::GalleryPreviewService.new
        @gallery_images_html = []
        @params[:files].each do |image|
          gallery_image = @gallery_image_model.create
          gallery_image.image.store!(image)
          @gallery.images << gallery_image
          @gallery_images_html << preview_service.preview_html(gallery_image.image)
        end
      end

    end
  end
end