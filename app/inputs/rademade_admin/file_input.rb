# -*- encoding : utf-8 -*-
module RademadeAdmin
  class FileInput < SimpleForm::Inputs::FileInput

    include UriHelper

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
          upload_progress_html, upload_button_html, crop_button_html, input_hidden_html
        ]),
        { :class => 'uploader-wrapper' }
      )
    end

    def input_file_html
      @builder.file_field(uploader.mounted_as, {
        :id => nil,
        :class => 'btn yellow-btn uploader-input-file',
        :name => uploader.mounted_as,
        :data => {
          :column => uploader.mounted_as,
          :id => object.id.to_s,
          :saved => object.new_record? ? 0 : 1,
          :model => object.class.to_s,
          :uploader => uploader.class.to_s,
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
        :class => 'btn green-btn upload-btn',
        :data => {
          :upload => true
        }
      })
    end

    def crop_button_html
      template.content_tag(:span, I18n.t('rademade_admin.crop'), {
        :class => 'btn red-btn upload-btn',
        :data => {
          :crop => true,
          :url => admin_url_for(:controller => 'file', :action => 'crop')
        }
      }) if photo_uploader?
    end

    def upload_preview_service
      @upload_preview_service ||= RademadeAdmin::Upload::PreviewService.new(uploader)
    end

    def uploader
      @uploader ||= input_html_options[:value] || object.send(attribute_name)
    end

    def photo_uploader?
      uploader.class.ancestors.include? RademadeAdmin::Uploader::Photo
    end

  end
end
