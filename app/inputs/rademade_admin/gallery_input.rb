# -*- encoding : utf-8 -*-
module RademadeAdmin
  class GalleryInput < SimpleForm::Inputs::Base

    include UriHelper

    def input(wrapper_options = {})
      template.content_tag(
        :div,
        HtmlBuffer.new([upload_button_html, gallery_images_html, gallery_hidden_html]),
        { :class => 'gallery' }
      )
    end

    private

    def upload_button_html
      template.content_tag(:input, '', {
        :class => 'btn gallery-image-upload',
        :type => 'file',
        :multiple => true,
        :data => {
          :url => admin_url_for(:controller => 'file', :action => 'gallery_upload'),
          :class_name => gallery_class.to_s
        }
      })
    end

    def gallery_images_html
      template.content_tag(:div, HtmlBuffer.new([images_html]), {
        :class => 'gallery-images-container'
      })
    end

    def gallery_hidden_html
      template.content_tag(:input, '', {
        :type => 'hidden',
        :name => "data[#{gallery_relation.getter}]",
        :value => gallery.id.to_s
      })
    end

    def images_html
      html = ''
      preview_service = RademadeAdmin::Upload::GalleryPreviewService.new
      gallery.images.each do |gallery_image|
        html += preview_service.preview_html(gallery_image.image)
      end
      html
    end

    def gallery
      @gallery ||= object.send(attribute_name) || gallery_class.create # todo
    end

    def gallery_relation
      @gallery_relation ||= RademadeAdmin::Model::Graph.instance.model_info(object.class.to_s).data_items.data_item(attribute_name)
    end

    def gallery_class
      @gallery_class ||= gallery_relation.relation.to
    end

  end
end