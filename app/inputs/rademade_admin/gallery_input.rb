# -*- encoding : utf-8 -*-
module RademadeAdmin
  class GalleryInput < SimpleForm::Inputs::Base

    include UriHelper

    def input(wrapper_options = {})
      template.content_tag(
        :div,
        HtmlBuffer.new([gallery_block_html, upload_block_html, gallery_hidden_html]),
        :class => 'upload-list',
        :data => { :gallery => '' }
      )
    end
    
    private
    
    def gallery_block_html
      is_sortable = gallery_image_info.sortable_relation?
      template.content_tag(:div, images_html,
        :class => 'upload-box',
        :data => {
          :sortable_url => is_sortable ? rademade_admin_route(:gallery_sort_url) : ''
        }
      )
    end

    def images_html
      html = []
      preview_service = RademadeAdmin::Upload::GalleryPreviewService.new
      gallery.images.each do |gallery_image|
        html << preview_service.preview_html(gallery_image.image)
      end
      HtmlBuffer.new(html)
    end

    def upload_block_html
      template.content_tag(
        :div,
        template.content_tag(:div, HtmlBuffer.new([
          upload_button_html,
          template.content_tag(:span, t('rademade_admin.uploader.gallery.add'), :class => 'upload-text')
        ]), :class => 'upload-item add'),
        :class => 'upload-holder'
      )
    end

    def upload_button_html
      template.content_tag(:input, '',
        :type => 'file',
        :multiple => true,
        :data => {
          :url => rademade_admin_route(:gallery_upload_url),
          :class_name => gallery_class.to_s
        }
      )
    end

    def gallery_hidden_html
      template.content_tag(:input, '', {
        :type => 'hidden',
        :name => "data[#{gallery_info.getter}]",
        :value => gallery.id.to_s
      })
    end

    def gallery
      @gallery ||= object.send(attribute_name) || gallery_class.create
    end

    def gallery_info
      @gallery_relation ||= model_info(object.class.to_s, attribute_name)
    end

    def gallery_image_info
      @gallery_image_info ||= model_info(gallery_class, :images)
    end

    def gallery_class
      @gallery_class ||= gallery_info.relation.to
    end

    def model_info(class_name, data_item_name)
      RademadeAdmin::Model::Graph.instance.model_info(class_name).data_items.data_item(data_item_name)
    end

  end
end