# -*- encoding : utf-8 -*-
module RademadeAdmin
  class FileInput < SimpleForm::Inputs::FileInput

    include UriHelper

    def initialize(*args)
      super
      @uploader = object.send(attribute_name)
    end

    def input
      template.content_tag(
        :div,
        HtmlBuffer.new([file_html]),
        { :class => 'uploader-block' }
      )
    end

    private

    def file_html
      template.content_tag(
        :div,
        HtmlBuffer.new([
          upload_preview_service.preview_html, input_file_html,
          upload_progress_html, upload_button_html, input_hidden_html
        ]),
        { :class => 'uploader-wrapper' }
      )
    end

    def input_file_html
      @builder.file_field(attribute_name, {
        :id => nil,
        :class => 'btn yellow-btn uploader-input-file',
        :name => attribute_name,
        :data => {
          :column => attribute_name,
          :id => object.id.to_s,
          :saved => object.new_record? ? 0 : 1,
          :model => object.class.to_s,
          :uploader => data_item.uploader.uploader.to_s,
          :url => admin_url_for(:controller => 'file', :action => 'upload')
        }
      })
    end

    def input_hidden_html
      @builder.hidden_field(attribute_name, {
        :class => 'uploader-input-hidden hidden'
      }.merge(input_html_options))
    end

    def upload_progress_html
      progress_slider = template.content_tag(:div, '', { :class => 'upload-progress' })
      template.content_tag(:div, progress_slider, {
        :class => 'upload-progress-wrapper'
      })
    end

    def upload_button_html
      template.content_tag(:span, I18n.t('rademade_admin.upload_file'), {
        :class => 'btn green-btn upload-btn'
      })
    end

    def upload_preview_service
      @upload_preview_service ||= RademadeAdmin::Upload::PreviewService.new(@uploader)
    end

    def data_item
      unless @data_item
        model_info = Model::Graph.instance.model_info(object.class)
        @data_item = model_info.data_items.data_item(attribute_name)
      end
      @data_item
    end

  end
end
